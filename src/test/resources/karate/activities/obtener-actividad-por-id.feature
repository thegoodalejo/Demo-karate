@activities
Feature: Obtener una actividad por identificador
  Como sistema de gestión de tareas
  El servicio permite consultar el detalle de una actividad específica
  Para que el cliente acceda a la información de una tarea en particular

  Background:
    * url baseUrl
    * def schema = read('classpath:request/activities/response-schema.json')

  @smoke @get-by-id
  Scenario: Obtener una actividad existente por su identificador
    Given path activitiesEndpoint, 1
    When method GET
    Then status 200
    And match response == schema

  @get-by-id @negativo
  Scenario: Intentar obtener una actividad con identificador inexistente
    Given path activitiesEndpoint, 9999
    When method GET
    Then status 404
