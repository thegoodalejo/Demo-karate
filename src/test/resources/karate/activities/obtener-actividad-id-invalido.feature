@activities @negativo
Feature: Obtener una actividad con identificador de formato inválido
  Como sistema de gestión de tareas
  El servicio rechaza la solicitud cuando el identificador no tiene un formato numérico válido
  Para proteger la integridad del sistema ante parámetros incorrectos

  Background:
    * url baseUrl

  @id-invalido
  Scenario Outline: Intentar obtener una actividad con identificador <descripcion>
    Given path activitiesEndpoint + '/<id>'
    When method GET
    Then status <estado>

    Examples:
      | descripcion  | id  | estado |
      | alfanumerico | abc | 400    |
      | negativo     | -1  | 400    |
      | igual a cero | 0   | 404    |
