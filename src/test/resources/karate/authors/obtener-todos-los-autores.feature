@authors
Feature: Obtener todos los autores
  Como sistema de gestión de autores
  El servicio expone un endpoint para listar todos los autores registrados
  Para que el cliente pueda consultar el catálogo completo de autores

  Background:
    * url baseUrl
    * def schema = read('classpath:request/authors/response-schema.json')

  @smoke @get-all
  Scenario: Obtener el listado completo de autores
    Given path authorsEndpoint
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
