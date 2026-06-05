@authors
Feature: Actualizar un autor
  Como sistema de gestión de autores
  El servicio permite modificar los datos de un autor existente
  Para que el cliente pueda mantener actualizada la información del catálogo

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/authors/request-body.json')
    * def schema      = read('classpath:request/authors/response-schema.json')

  @smoke @update
  Scenario: Actualizar un autor existente con datos válidos
    Given path authorsEndpoint, 1
    And request requestBody
    When method PUT
    Then status 200
    And match response == schema
