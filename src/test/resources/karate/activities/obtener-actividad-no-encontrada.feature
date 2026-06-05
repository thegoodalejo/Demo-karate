@activities @negativo
Feature: Obtener una actividad no encontrada
  Como sistema de gestión de tareas
  El servicio informa al cliente cuando el recurso solicitado no existe
  Para que pueda gestionar correctamente la ausencia del registro

  Background:
    * url baseUrl

  @smoke @not-found
  Scenario: Intentar obtener una actividad con identificador no registrado en el sistema
    Given path activitiesEndpoint, 99999
    When method GET
    Then status 404
