@coverphotos @negativo
Feature: Obtener portadas de un libro no encontrado
  Como sistema de gestión de portadas
  El servicio retorna una colección vacía cuando no existen portadas para el libro indicado
  Para que el cliente distinga entre un error de recurso y la ausencia de resultados

  Background:
    * url baseUrl

  @get-by-book @coleccion-vacia
  Scenario: Obtener una colección vacía al consultar portadas de un libro no registrado
    Given path coversByBookEndpoint, 99999
    When method GET
    Then status 200
    And match response == '#[]'
