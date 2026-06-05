@coverphotos @negativo
Feature: Crear una portada con datos inválidos
  Como sistema de gestión de portadas
  El servicio rechaza la creación cuando los datos enviados no cumplen el formato esperado
  Para garantizar la integridad de los registros almacenados

  Background:
    * url baseUrl

  @create @cuerpo-vacio
  Scenario: Intentar crear una portada con cuerpo de petición vacío
    Given path coverPhotosEndpoint
    And request {}
    When method POST
    Then status 400

  @create @tipos-invalidos
  Scenario: Intentar crear una portada con tipos de datos incorrectos en los campos
    Given path coverPhotosEndpoint
    And request { id: 'texto', idBook: 'no-es-numero', url: 12345 }
    When method POST
    Then status 400
