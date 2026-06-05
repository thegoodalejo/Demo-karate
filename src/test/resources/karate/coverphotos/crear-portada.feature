@coverphotos
Feature: Crear una portada
  Como sistema de gestión de portadas
  El servicio permite registrar nuevas portadas asociadas a libros
  Para que el cliente pueda incorporar imágenes de portada al catálogo

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/coverphotos/request-body.json')
    * def schema      = read('classpath:request/coverphotos/response-schema.json')

  @smoke @create
  Scenario: Crear una portada con datos válidos
    Given path coverPhotosEndpoint
    And request requestBody
    When method POST
    Then status 200
    And match response == schema
    And match response.id == '#number'
