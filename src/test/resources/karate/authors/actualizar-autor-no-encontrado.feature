@authors @negativo
Feature: Actualizar un autor no encontrado
  Como sistema de gestión de autores
  El servicio informa al cliente cuando intenta modificar un recurso que no existe
  Para evitar actualizaciones sobre registros inexistentes

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/authors/request-body.json')

  @update @not-found
  Scenario: Intentar actualizar un autor con identificador no registrado en el sistema
    Given path authorsEndpoint, 99999
    And request requestBody
    When method PUT
    Then status 404
