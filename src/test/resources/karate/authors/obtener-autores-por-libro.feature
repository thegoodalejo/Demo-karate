@authors
Feature: Obtener autores por libro
  Como sistema de gestión de autores
  El servicio permite consultar todos los autores asociados a un libro
  Para que el cliente pueda conocer la autoría de una publicación específica

  Background:
    * url baseUrl
    * def schema = read('classpath:request/authors/response-schema.json')

  @smoke @get-by-book
  Scenario: Obtener los autores asociados a un libro existente
    Given path authorsByBookEndpoint, 1
    When method GET
    Then status 200
    And match response == '#[]'
    And match each response == schema
