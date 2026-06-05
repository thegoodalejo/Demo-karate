@activities
Feature: Obtener todas las actividades
  Como sistema de gestión de tareas
  El servicio expone un endpoint para listar todas las actividades registradas
  Para permitir al cliente visualizar el estado global de las tareas

  Background:
    * url baseUrl
    * def schema = read('classpath:request/activities/response-schema.json')

  @smoke @get-all
  Scenario: Obtener el listado completo de actividades
    Given path activitiesEndpoint
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
