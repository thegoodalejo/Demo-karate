@users @negativo
Feature: Crear un usuario con datos inválidos
  Como sistema de gestión de usuarios
  El servicio rechaza la creación cuando los datos enviados no cumplen el formato esperado
  Para garantizar la integridad de los registros almacenados

  Background:
    * url baseUrl

  @create @cuerpo-vacio
  Scenario: Intentar crear un usuario con cuerpo de petición vacío
    Given path usersEndpoint
    And request {}
    When method POST
    Then status 400

  @create @tipos-invalidos
  Scenario: Intentar crear un usuario con tipos de datos incorrectos en los campos
    Given path usersEndpoint
    And request { id: 'texto', userName: 12345, password: true }
    When method POST
    Then status 400
