@coverphotos
Feature: Actualizar una portada
  Como sistema de gestión de portadas
  El servicio permite modificar los datos de una portada existente
  Para que el cliente pueda mantener actualizadas las imágenes de portada del catálogo

  Background:
    * url baseUrl
    * def requestBody = read('classpath:request/coverphotos/request-body.json')
    * def schema      = read('classpath:request/coverphotos/response-schema.json')

  @smoke @update
  Scenario: Actualizar una portada existente con datos válidos
    Given path coverPhotosEndpoint, 1
    And request requestBody
    When method PUT
    Then status 200
    And match response == schema
