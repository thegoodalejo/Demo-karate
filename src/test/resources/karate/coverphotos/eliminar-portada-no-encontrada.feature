@coverphotos @negativo
Feature: Eliminar una portada no encontrada
  Como sistema de gestión de portadas
  El servicio informa al cliente cuando intenta eliminar un recurso que no existe
  Para evitar operaciones de borrado sobre registros inexistentes

  Background:
    * url baseUrl

  @delete @not-found
  Scenario: Intentar eliminar una portada con identificador no registrado en el sistema
    Given path coverPhotosEndpoint, 99999
    When method DELETE
    Then status 404
