require 'zoom'

Zoom.configure do |c|
  c.api_key = Rails.application.credentials.zoom[:apikey]
  c.api_secret = Rails.application.credentials.zoom[:api_secret]
end
