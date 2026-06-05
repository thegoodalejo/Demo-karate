@books @negativo
Feature: Obtener un libro no encontrado
  Como sistema de gestión de biblioteca
  El servicio informa al cliente cuando el recurso solicitado no existe
  Para que pueda gestionar correctamente la ausencia del registro

  Background:
    * url baseUrl

  @smoke @not-found
  Scenario: Intentar obtener un libro con identificador no registrado en el sistema
    Given path booksEndpoint, 99999
    When method GET
    Then status 404
