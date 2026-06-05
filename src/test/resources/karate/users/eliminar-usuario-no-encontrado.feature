@users @negativo
Feature: Eliminar un usuario no encontrado
  Como sistema de gestión de usuarios
  El servicio informa al cliente cuando intenta eliminar un recurso que no existe
  Para evitar operaciones de borrado sobre registros inexistentes

  Background:
    * url baseUrl

  @delete @not-found
  Scenario: Intentar eliminar un usuario con identificador no registrado en el sistema
    Given path usersEndpoint, 99999
    When method DELETE
    Then status 404
