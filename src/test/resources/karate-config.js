function fn() {

  // --- URL base ---
  var baseUrl = karate.properties['baseUrl'] || 'https://fakerestapi.azurewebsites.net';

  // --- Endpoints ---
  var activitiesEndpoint    = '/api/v1/Activities';
  var authorsEndpoint       = '/api/v1/Authors';
  var authorsByBookEndpoint = '/api/v1/Authors/authors/books';
  var booksEndpoint         = '/api/v1/Books';
  var coverPhotosEndpoint   = '/api/v1/CoverPhotos';
  var coversByBookEndpoint  = '/api/v1/CoverPhotos/books/covers';
  var usersEndpoint         = '/api/v1/Users';

  // --- Configuración HTTP global ---
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout',    20000);
  karate.configure('ssl',            true);
  karate.configure('logPrettyRequest',  true);
  karate.configure('logPrettyResponse', true);

  // --- Autenticación Microsoft Azure AD ---
  //
  // Modo local:  -Dauth.token=eyJhbGci...   (token copiado de Postman / DevTools)
  // Modo CI:     -Dauth.enabled=true -Dauth.tenantId=... -Dauth.clientId=... -Dauth.clientSecret=...
  //
  // Prioridad: token manual > client credentials > sin auth
  var authToken   = '';
  var manualToken = karate.properties['auth.token'] || '';

  if (manualToken) {
    // Local: el desarrollador obtiene el token manualmente (Postman, navegador, az cli, etc.)
    // Se pasa solo el valor del token, sin el prefijo "Bearer".
    authToken = 'Bearer ' + manualToken;
    karate.configure('headers', { Authorization: authToken });
    karate.log('[AUTH] Modo local — token manual inyectado via -Dauth.token');

  } else if (karate.properties['auth.enabled'] === 'true') {
    // CI: flujo automatizado Client Credentials (sin MFA, funciona en pipelines Azure/GitHub).
    // callSingle ejecuta el feature UNA SOLA VEZ por corrida y cachea el resultado,
    // evitando una llamada a Azure AD por cada escenario paralelo.
    var tenantId     = karate.properties['auth.tenantId']     || '';
    var clientId     = karate.properties['auth.clientId']     || '';
    var clientSecret = karate.properties['auth.clientSecret'] || '';
    var scope        = karate.properties['auth.scope']        || 'https://graph.microsoft.com/.default';

    var tokenResult = karate.callSingle(
      'classpath:karate/auth/microsoft-token.feature',
      {
        msLoginUrl:   'https://login.microsoftonline.com',
        tenantId:     tenantId,
        clientId:     clientId,
        clientSecret: clientSecret,
        scope:        scope
      }
    );

    authToken = tokenResult.tokenType + ' ' + tokenResult.accessToken;
    karate.configure('headers', { Authorization: authToken });
    karate.log('[AUTH] Modo CI — token obtenido via Client Credentials, expira en', tokenResult.expiresIn, 'segundos');

  } else {
    karate.log('[AUTH] Sin autenticación — para activar usa -Dauth.token=<token> o -Dauth.enabled=true');
  }

  return Object.assign(
    { baseUrl:               baseUrl               },
    { activitiesEndpoint:    activitiesEndpoint     },
    { authorsEndpoint:       authorsEndpoint        },
    { authorsByBookEndpoint: authorsByBookEndpoint  },
    { booksEndpoint:         booksEndpoint          },
    { coverPhotosEndpoint:   coverPhotosEndpoint    },
    { coversByBookEndpoint:  coversByBookEndpoint   },
    { usersEndpoint:         usersEndpoint          },
    { authToken:             authToken              }
  );
}
