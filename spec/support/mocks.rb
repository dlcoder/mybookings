# OmniAuth mocks for integration tests
OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:saml] = {
  'provider' => 'saml',
  'uid' => '12354567890',
  'info' => {
    'email' => 'user@example.com'
  }
}
