@authors @negativo
Feature: Obtener un autor con identificador de formato inválido
  Como sistema de gestión de autores
  El servicio rechaza la solicitud cuando el identificador no tiene un formato numérico válido
  Para proteger la integridad del sistema ante parámetros incorrectos

  Background:
    * url baseUrl

  @id-invalido
  Scenario Outline: Intentar obtener un autor con identificador <descripcion>
    Given path authorsEndpoint + '/<id>'
    When method GET
    Then status <estado>

    Examples:
      | descripcion  | id  | estado |
      | alfanumerico | abc | 400    |
      | negativo     | -1  | 400    |
      | igual a cero | 0   | 404    |
