@authors
Feature: Crear un autor
  Como sistema de gestión de autores
  El servicio permite registrar nuevos autores en el catálogo
  Para que el cliente pueda incorporar nuevas entradas de autoría

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/authors/request-body.json')
    * def schema      = read('classpath:request/authors/response-schema.json')

  @smoke @create
  Scenario: Crear un autor con datos válidos
    Given path authorsEndpoint
    And request requestBody
    When method POST
    Then status 200
    And match response == schema
    And match response.id == '#number'
