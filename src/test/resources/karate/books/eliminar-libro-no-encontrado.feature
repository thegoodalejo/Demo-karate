@books @negativo
Feature: Eliminar un libro no encontrado
  Como sistema de gestión de biblioteca
  El servicio informa al cliente cuando intenta eliminar un recurso que no existe
  Para evitar operaciones de borrado sobre registros inexistentes

  Background:
    * url baseUrl

  @delete @not-found
  Scenario: Intentar eliminar un libro con identificador no registrado en el sistema
    Given path booksEndpoint, 99999
    When method DELETE
    Then status 404
