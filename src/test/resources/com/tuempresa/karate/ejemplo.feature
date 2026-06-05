Feature: Ejemplo básico

  Scenario: Llamado a API pública
    Given url 'https://jsonplaceholder.typicode.com/todos/1'
    When method GET
    Then status 200
    And match response.id == 1