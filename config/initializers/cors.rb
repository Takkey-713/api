Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    Rails.ENV == "development"  ? origins 'localhost:3000' : origins '52.192.7.231'
    # いじるポイント

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
      # expose["access-token"]
  end
end