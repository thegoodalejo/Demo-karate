@books @negativo
Feature: Actualizar un libro no encontrado
  Como sistema de gestión de biblioteca
  El servicio informa al cliente cuando intenta modificar un recurso que no existe
  Para evitar actualizaciones sobre registros inexistentes

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/books/request-body.json')

  @update @not-found
  Scenario: Intentar actualizar un libro con identificador no registrado en el sistema
    Given path booksEndpoint, 99999
    And request requestBody
    When method PUT
    Then status 404
