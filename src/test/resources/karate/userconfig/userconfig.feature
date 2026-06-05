Feature: User Config API

  Background:
    * url baseUrl
    * def schema   = read('classpath:request/userconfig/response-schema.json')
    * def createBody = read('classpath:request/userconfig/create-body.json')

  @create
  Scenario: Crear configuracion de usuario
    Given path userconfigEndpoint
    And request createBody
    When method POST
    Then status 201
    And match response == schema

  @read
  Scenario: Obtener configuracion de usuario
    Given path userconfigEndpoint + '/1'
    When method GET
    Then status 200
    And match response == schema

  @update
  Scenario: Actualizar configuracion de usuario
    Given path userconfigEndpoint + '/1'
    And request createBody
    When method PUT
    Then status 200
    And match response == schema

  @delete
  Scenario: Eliminar configuracion de usuario
    Given path userconfigEndpoint + '/1'
    When method DELETE
    Then status 200
