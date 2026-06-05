@users @negativo
Feature: Actualizar un usuario no encontrado
  Como sistema de gestión de usuarios
  El servicio informa al cliente cuando intenta modificar un recurso que no existe
  Para evitar actualizaciones sobre registros inexistentes

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/users/request-body.json')

  @update @not-found
  Scenario: Intentar actualizar un usuario con identificador no registrado en el sistema
    Given path usersEndpoint, 99999
    And request requestBody
    When method PUT
    Then status 404
