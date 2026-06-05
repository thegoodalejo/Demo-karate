@books @negativo
Feature: Crear un libro con datos inválidos
  Como sistema de gestión de biblioteca
  El servicio rechaza la creación cuando los datos enviados no cumplen el formato esperado
  Para garantizar la integridad de los registros almacenados

  Background:
    * url baseUrl

  @create @cuerpo-vacio
  Scenario: Intentar crear un libro con cuerpo de petición vacío
    Given path booksEndpoint
    And request {}
    When method POST
    Then status 400

  @create @tipos-invalidos
  Scenario: Intentar crear un libro con tipos de datos incorrectos en los campos
    Given path booksEndpoint
    And request { id: 'texto', title: 99, description: true, pageCount: 'no-es-numero', excerpt: false, publishDate: 12345 }
    When method POST
    Then status 400
