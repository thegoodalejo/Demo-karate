@authors @negativo
Feature: Eliminar un autor no encontrado
  Como sistema de gestión de autores
  El servicio informa al cliente cuando intenta eliminar un recurso que no existe
  Para evitar operaciones de borrado sobre registros inexistentes

  Background:
    * url baseUrl

  @delete @not-found
  Scenario: Intentar eliminar un autor con identificador no registrado en el sistema
    Given path authorsEndpoint, 99999
    When method DELETE
    Then status 404
