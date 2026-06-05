@activities @negativo
Feature: Eliminar una actividad no encontrada
  Como sistema de gestión de tareas
  El servicio informa al cliente cuando intenta eliminar un recurso que no existe
  Para evitar operaciones de borrado sobre registros inexistentes

  Background:
    * url baseUrl

  @delete @not-found
  Scenario: Intentar eliminar una actividad con identificador no registrado en el sistema
    Given path activitiesEndpoint, 99999
    When method DELETE
    Then status 404
