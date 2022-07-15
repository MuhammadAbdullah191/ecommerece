Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'

    resource '*',
      headers: :any,
      methods: [:get, :post, :delete]
  end
  # allow do
  #   origins 'http://localhost:6000'
  #   resource '*', headers: :any, methods: [:get, :post, :options, :put, :delete]
  # end
end