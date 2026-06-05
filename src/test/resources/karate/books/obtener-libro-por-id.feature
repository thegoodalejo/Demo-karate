@books
Feature: Obtener un libro por identificador
  Como sistema de gestión de biblioteca
  El servicio permite consultar el detalle de un libro específico
  Para que el cliente acceda a la información completa de una publicación

  Background:
    * url baseUrl
    * def schema = read('classpath:request/books/response-schema.json')

  @smoke @get-by-id
  Scenario: Obtener un libro existente por su identificador
    Given path booksEndpoint, 1
    When method GET
    Then status 200
    And match response == schema

  @get-by-id @negativo
  Scenario: Intentar obtener un libro con identificador inexistente
    Given path booksEndpoint, 9999
    When method GET
    Then status 404
