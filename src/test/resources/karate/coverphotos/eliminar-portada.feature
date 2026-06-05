@coverphotos
Feature: Eliminar una portada
  Como sistema de gestión de portadas
  El servicio permite eliminar una portada registrada del catálogo
  Para que el cliente pueda gestionar las imágenes de portada disponibles

  Background:
    * url baseUrl

  @smoke @delete
  Scenario: Eliminar una portada existente del sistema
    Given path coverPhotosEndpoint, 1
    When method DELETE
    Then status 200
