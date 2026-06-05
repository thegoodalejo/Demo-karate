@coverphotos
Feature: Obtener una portada por identificador
  Como sistema de gestión de portadas
  El servicio permite consultar el detalle de una portada específica
  Para que el cliente acceda a la información de una imagen de portada en particular

  Background:
    * url baseUrl
    * def schema = read('classpath:request/coverphotos/response-schema.json')

  @smoke @get-by-id
  Scenario: Obtener una portada existente por su identificador
    Given path coverPhotosEndpoint, 1
    When method GET
    Then status 200
    And match response == schema

  @get-by-id @negativo
  Scenario: Intentar obtener una portada con identificador inexistente
    Given path coverPhotosEndpoint, 9999
    When method GET
    Then status 404
