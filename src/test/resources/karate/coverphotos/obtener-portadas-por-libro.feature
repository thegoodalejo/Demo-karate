@coverphotos
Feature: Obtener portadas por libro
  Como sistema de gestión de portadas
  El servicio permite consultar todas las portadas asociadas a un libro
  Para que el cliente pueda conocer las imágenes disponibles para una publicación

  Background:
    * url baseUrl
    * def schema = read('classpath:request/coverphotos/response-schema.json')

  @smoke @get-by-book
  Scenario: Obtener las portadas asociadas a un libro existente
    Given path coversByBookEndpoint, 1
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
