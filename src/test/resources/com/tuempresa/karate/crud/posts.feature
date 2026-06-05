@crud
Feature: CRUD de Posts

  Background:
    * url baseUrl
    * def postNuevo = { title: 'Post de prueba', body: 'Contenido demo', userId: 1 }

  @create
  Scenario: Crear un nuevo post
    Given path '/posts'
    And request postNuevo
    When method POST
    Then status 201
    And match response.id == '#number'
    And match response.title == 'Post de prueba'
    And match response.userId == 1

  @read
  Scenario: Listar todos los posts
    Given path '/posts'
    When method GET
    Then status 200
    And match response == '#array'
    And match response[0] == { id: '#number', title: '#string', body: '#string', userId: '#number' }

  @read
  Scenario: Obtener un post por ID
    Given path '/posts/1'
    When method GET
    Then status 200
    And match response == { id: 1, title: '#string', body: '#string', userId: '#number' }

  @update
  Scenario: Actualizar un post completo (PUT)
    Given path '/posts/1'
    And request { id: 1, title: 'Post actualizado', body: 'Cuerpo actualizado', userId: 1 }
    When method PUT
    Then status 200
    And match response.title == 'Post actualizado'
    And match response.id == 1

  @update
  Scenario: Actualizar parcialmente un post (PATCH)
    Given path '/posts/1'
    And request { title: 'Titulo parcial' }
    When method PATCH
    Then status 200
    And match response.title == 'Titulo parcial'

  @delete
  Scenario: Eliminar un post
    Given path '/posts/1'
    When method DELETE
    Then status 200
