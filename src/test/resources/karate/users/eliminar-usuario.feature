@users
Feature: Eliminar un usuario
  Como sistema de gestión de usuarios
  El servicio permite eliminar un usuario registrado del directorio
  Para que el cliente pueda gestionar las cuentas activas en el sistema

  Background:
    * url baseUrl

  @smoke @delete
  Scenario: Eliminar un usuario existente del sistema
    Given path usersEndpoint, 1
    When method DELETE
    Then status 200
