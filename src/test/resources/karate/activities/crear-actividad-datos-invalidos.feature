@activities @negativo
Feature: Crear una actividad con datos inválidos
  Como sistema de gestión de tareas
  El servicio rechaza la creación cuando los datos enviados no cumplen el formato esperado
  Para garantizar la integridad de los registros almacenados

  Background:
    * url baseUrl

  @create @cuerpo-vacio
  Scenario: Intentar crear una actividad con cuerpo de petición vacío
    Given path activitiesEndpoint
    And request {}
    When method POST
    Then status 400

  @create @tipos-invalidos
  Scenario: Intentar crear una actividad con tipos de datos incorrectos en los campos
    Given path activitiesEndpoint
    And request { id: 'texto', title: 99, dueDate: 'no-es-fecha', completed: 'si' }
    When method POST
    Then status 400
