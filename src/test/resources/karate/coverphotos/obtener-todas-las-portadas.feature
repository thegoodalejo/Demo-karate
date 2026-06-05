@coverphotos
Feature: Obtener todas las portadas
  Como sistema de gestión de portadas
  El servicio expone un endpoint para listar todas las portadas registradas
  Para que el cliente pueda consultar el catálogo completo de imágenes de portada

  Background:
    * url baseUrl
    * def schema = read('classpath:request/coverphotos/response-schema.json')

  @smoke @get-all
  Scenario: Obtener el listado completo de portadas
    Given path coverPhotosEndpoint
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
