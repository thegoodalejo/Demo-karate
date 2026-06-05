@users
Feature: Actualizar un usuario
  Como sistema de gestión de usuarios
  El servicio permite modificar los datos de un usuario existente
  Para que el cliente pueda mantener actualizada la información del directorio

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/users/request-body.json')
    * def schema      = read('classpath:request/users/response-schema.json')

  @smoke @update
  Scenario: Actualizar un usuario existente con datos válidos
    Given path usersEndpoint, 1
    And request requestBody
    When method PUT
    Then status 200
    And match response == schema
