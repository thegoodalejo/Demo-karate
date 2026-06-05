@authors
Feature: Obtener un autor por identificador
  Como sistema de gestión de autores
  El servicio permite consultar el detalle de un autor específico
  Para que el cliente acceda a la información individual de cada autor

  Background:
    * url baseUrl
    * def schema = read('classpath:request/authors/response-schema.json')

  @smoke @get-by-id
  Scenario: Obtener un autor existente por su identificador
    Given path authorsEndpoint, 1
    When method GET
    Then status 200
    And match response == schema

  @get-by-id @negativo
  Scenario: Intentar obtener un autor con identificador inexistente
    Given path authorsEndpoint, 9999
    When method GET
    Then status 404
