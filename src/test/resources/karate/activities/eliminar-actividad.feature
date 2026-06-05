@activities
Feature: Eliminar una actividad
  Como sistema de gestión de tareas
  El servicio permite eliminar una actividad registrada
  Para que el cliente pueda depurar el listado de tareas del sistema

  Background:
    * url baseUrl

  @smoke @delete
  Scenario: Eliminar una actividad existente del sistema
    Given path activitiesEndpoint, 1
    When method DELETE
    Then status 200
