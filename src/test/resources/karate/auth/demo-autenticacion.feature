@auth @smoke
Feature: Demostrar autenticación con token Microsoft
  Como servicio protegido por Azure AD
  El cliente incluye automáticamente el token Bearer en cada petición
  Para acceder a recursos que requieren autenticación

  Background:
    * url baseUrl

  @demo @token-presente
  Scenario: Verificar que el token Bearer está disponible en el contexto global
    * def token = karate.info.karate.config.authToken
    * print 'Token disponible (primeros 20 chars):', token.substring(0, 20) + '...'
    * match token == '#string'

  @demo @header-autorizacion
  Scenario: Confirmar que el header Authorization se envía automáticamente en los requests
    Given path '/api/v1/Users'
    When method GET
    Then status 200
    * print 'Request ejecutado con Authorization header inyectado globalmente'
