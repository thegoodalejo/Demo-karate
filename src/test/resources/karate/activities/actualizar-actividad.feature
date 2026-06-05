@activities
Feature: Actualizar una actividad
  Como sistema de gestión de tareas
  El servicio permite modificar los datos de una actividad existente
  Para que el cliente pueda mantener actualizada la información de las tareas

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/activities/request-body.json')
    * def schema      = read('classpath:request/activities/response-schema.json')

  @smoke @update
  Scenario: Actualizar una actividad existente con datos válidos
    Given path activitiesEndpoint, 1
    And request requestBody
    When method PUT
    Then status 200
    And match response == schema
