@users
Feature: Crear un usuario
  Como sistema de gestión de usuarios
  El servicio permite registrar nuevos usuarios en el sistema
  Para que el cliente pueda incorporar nuevas cuentas al directorio

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/users/request-body.json')
    * def schema      = read('classpath:request/users/response-schema.json')

  @smoke @create
  Scenario: Crear un usuario con datos válidos
    Given path usersEndpoint
    And request requestBody
    When method POST
    Then status 200
    And match response == schema
    And match response.id == '#number'
