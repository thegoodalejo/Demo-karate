@books
Feature: Eliminar un libro
  Como sistema de gestión de biblioteca
  El servicio permite eliminar un libro del catálogo
  Para que el cliente pueda gestionar las publicaciones registradas en el sistema

  Background:
    * url baseUrl

  @smoke @delete
  Scenario: Eliminar un libro existente del sistema
    Given path booksEndpoint, 1
    When method DELETE
    Then status 200
