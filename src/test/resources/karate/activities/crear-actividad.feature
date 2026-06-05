@activities
Feature: Crear una actividad
  Como sistema de gestión de tareas
  El servicio permite registrar nuevas actividades
  Para que el cliente pueda incorporar nuevas tareas al sistema

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/activities/request-body.json')
    * def schema      = read('classpath:request/activities/response-schema.json')

  @smoke @create
  Scenario: Crear una actividad con datos válidos
    Given path activitiesEndpoint
    And request requestBody
    When method POST
    Then status 200
    And match response == schema
    And match response.id == '#number'
