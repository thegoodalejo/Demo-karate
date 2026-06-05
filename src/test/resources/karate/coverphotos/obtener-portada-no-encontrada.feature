@coverphotos @negativo
Feature: Obtener una portada no encontrada
  Como sistema de gestión de portadas
  El servicio informa al cliente cuando el recurso solicitado no existe
  Para que pueda gestionar correctamente la ausencia del registro

  Background:
    * url baseUrl

  @smoke @not-found
  Scenario: Intentar obtener una portada con identificador no registrado en el sistema
    Given path coverPhotosEndpoint, 99999
    When method GET
    Then status 404
