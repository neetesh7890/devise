OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = 'http://localhost:3000'

Rails.application.config.middleware.use OmniAuth::Builder do   
  provider :google_oauth2, '130895759937-lbp74cd68v8t2fa5hnsoicejf0hth3hr.apps.googleusercontent.com','f2jLo3PUuMo8t_PVOr4X82nP',{}
end


# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
# end



# OmniAuth.config.logger = Rails.logger
# OmniAuth.config.full_host = 'http://localhost:3000'

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :google_oauth2, '130895759937-lbp74cd68v8t2fa5hnsoicejf0hth3hr.apps.googleusercontent.com', 'f2jLo3PUuMo8t_PVOr4X82nP', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, :provider_ignores_state => true}
# end


