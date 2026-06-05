@authors
Feature: Eliminar un autor
  Como sistema de gestión de autores
  El servicio permite eliminar un autor del catálogo
  Para que el cliente pueda gestionar las entradas de autoría registradas

  Background:
    * url baseUrl

  @smoke @delete
  Scenario: Eliminar un autor existente del sistema
    Given path authorsEndpoint, 1
    When method DELETE
    Then status 200
