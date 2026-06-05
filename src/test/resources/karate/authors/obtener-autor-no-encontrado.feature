@authors @negativo
Feature: Obtener un autor no encontrado
  Como sistema de gestión de autores
  El servicio informa al cliente cuando el recurso solicitado no existe
  Para que pueda gestionar correctamente la ausencia del registro

  Background:
    * url baseUrl

  @smoke @not-found
  Scenario: Intentar obtener un autor con identificador no registrado en el sistema
    Given path authorsEndpoint, 99999
    When method GET
    Then status 404
