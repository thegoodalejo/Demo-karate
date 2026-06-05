@users @negativo
Feature: Obtener un usuario no encontrado
  Como sistema de gestión de usuarios
  El servicio informa al cliente cuando el recurso solicitado no existe
  Para que pueda gestionar correctamente la ausencia del registro

  Background:
    * url baseUrl

  @smoke @not-found
  Scenario: Intentar obtener un usuario con identificador no registrado en el sistema
    Given path usersEndpoint, 99999
    When method GET
    Then status 404
