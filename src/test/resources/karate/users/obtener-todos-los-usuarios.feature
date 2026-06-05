@users
Feature: Obtener todos los usuarios
  Como sistema de gestión de usuarios
  El servicio expone un endpoint para listar todos los usuarios registrados
  Para que el cliente pueda consultar el directorio completo de cuentas

  Background:
    * url baseUrl
    * def schema = read('classpath:request/users/response-schema.json')

  @smoke @get-all
  Scenario: Obtener el listado completo de usuarios
    Given path usersEndpoint
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
