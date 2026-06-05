@activities @negativo
Feature: Actualizar una actividad no encontrada
  Como sistema de gestión de tareas
  El servicio informa al cliente cuando intenta modificar un recurso que no existe
  Para evitar actualizaciones sobre registros inexistentes

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/activities/request-body.json')

  @update @not-found
  Scenario: Intentar actualizar una actividad con identificador no registrado en el sistema
    Given path activitiesEndpoint, 99999
    And request requestBody
    When method PUT
    Then status 404
