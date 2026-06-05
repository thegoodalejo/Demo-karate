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

  return Object.assign(
    { baseUrl:              baseUrl              },
    { activitiesEndpoint:   activitiesEndpoint   },
    { authorsEndpoint:      authorsEndpoint      },
    { authorsByBookEndpoint: authorsByBookEndpoint },
    { booksEndpoint:        booksEndpoint        },
    { coverPhotosEndpoint:  coverPhotosEndpoint  },
    { coversByBookEndpoint: coversByBookEndpoint },
    { usersEndpoint:        usersEndpoint        }
  );
}
