Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Yahan aap allowed origins specify kar sakte hain
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'] # Agar aap kuch headers expose karna chahte hain
  end
end
