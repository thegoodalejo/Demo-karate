@books
Feature: Crear un libro
  Como sistema de gestión de biblioteca
  El servicio permite registrar nuevos libros en el catálogo
  Para que el cliente pueda incorporar nuevas publicaciones al sistema

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/books/request-body.json')
    * def schema      = read('classpath:request/books/response-schema.json')

  @smoke @create
  Scenario: Crear un libro con datos válidos
    Given path booksEndpoint
    And request requestBody
    When method POST
    Then status 200
    And match response == schema
    And match response.id == '#number'
