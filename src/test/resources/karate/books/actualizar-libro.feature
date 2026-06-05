@books
Feature: Actualizar un libro
  Como sistema de gestión de biblioteca
  El servicio permite modificar los datos de un libro existente
  Para que el cliente pueda mantener actualizado el catálogo de publicaciones

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/books/request-body.json')
    * def schema      = read('classpath:request/books/response-schema.json')

  @smoke @update
  Scenario: Actualizar un libro existente con datos válidos
    Given path booksEndpoint, 1
    And request requestBody
    When method PUT
    Then status 200
    And match response == schema
