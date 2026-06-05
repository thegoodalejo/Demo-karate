@coverphotos @negativo
Feature: Actualizar una portada no encontrada
  Como sistema de gestión de portadas
  El servicio informa al cliente cuando intenta modificar un recurso que no existe
  Para evitar actualizaciones sobre registros inexistentes

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/coverphotos/request-body.json')

  @update @not-found
  Scenario: Intentar actualizar una portada con identificador no registrado en el sistema
    Given path coverPhotosEndpoint, 99999
    And request requestBody
    When method PUT
    Then status 404
