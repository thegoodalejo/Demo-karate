@authors @negativo
Feature: Obtener autores de un libro no encontrado
  Como sistema de gestión de autores
  El servicio retorna una colección vacía cuando no existen autores para el libro indicado
  Para que el cliente distinga entre un error de recurso y la ausencia de resultados

  Background:
    * url baseUrl

  @get-by-book @coleccion-vacia
  Scenario: Obtener una colección vacía al consultar autores de un libro no registrado
    Given path authorsByBookEndpoint, 99999
    When method GET
    Then status 200
    And match response == '#[]'
