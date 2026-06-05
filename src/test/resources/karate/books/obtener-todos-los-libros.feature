@books
Feature: Obtener todos los libros
  Como sistema de gestión de biblioteca
  El servicio expone un endpoint para listar todos los libros disponibles
  Para que el cliente pueda consultar el catálogo completo de publicaciones

  Background:
    * url baseUrl
    * def schema = read('classpath:request/books/response-schema.json')

  @smoke @get-all
  Scenario: Obtener el listado completo de libros
    Given path booksEndpoint
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
