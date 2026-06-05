@authors @negativo
Feature: Crear un autor con datos inválidos
  Como sistema de gestión de autores
  El servicio rechaza la creación cuando los datos enviados no cumplen el formato esperado
  Para garantizar la integridad de los registros almacenados

  Background:
    * url baseUrl

  @create @cuerpo-vacio
  Scenario: Intentar crear un autor con cuerpo de petición vacío
    Given path authorsEndpoint
    And request {}
    When method POST
    Then status 400

  @create @tipos-invalidos
  Scenario: Intentar crear un autor con tipos de datos incorrectos en los campos
    Given path authorsEndpoint
    And request { id: 'texto', idBook: 'no-es-numero', firstName: 123, lastName: true }
    When method POST
    Then status 400
