Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    Rails.env.production? ? (origins 'http://task-app-demo.com/') : (origins 'http://localhost:3000')
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
      # expose["access-token"]
  end
end