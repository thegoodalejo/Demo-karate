@users
Feature: Obtener un usuario por identificador
  Como sistema de gestión de usuarios
  El servicio permite consultar el detalle de un usuario específico
  Para que el cliente acceda a la información de una cuenta en particular

  Background:
    * url baseUrl
    * def schema = read('classpath:request/users/response-schema.json')

  @smoke @get-by-id
  Scenario: Obtener un usuario existente por su identificador
    Given path usersEndpoint, 1
    When method GET
    Then status 200
    And match response == schema

  @get-by-id @negativo
  Scenario: Intentar obtener un usuario con identificador inexistente
    Given path usersEndpoint, 9999
    When method GET
    Then status 404
