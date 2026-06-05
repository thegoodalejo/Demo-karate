@ignore
Feature: Obtener token de acceso Microsoft Azure AD

  Scenario: Solicitar token mediante Client Credentials Flow
    Given url msLoginUrl + '/' + tenantId + '/oauth2/v2.0/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form fields
      """
      {
        grant_type:    'client_credentials',
        client_id:     '#(clientId)',
        client_secret: '#(clientSecret)',
        scope:         '#(scope)'
      }
      """
    When method POST
    Then status 200
    * match response contains { access_token: '#string', token_type: '#string', expires_in: '#number' }
    * def accessToken = response.access_token
    * def tokenType   = response.token_type
    * def expiresIn   = response.expires_in
