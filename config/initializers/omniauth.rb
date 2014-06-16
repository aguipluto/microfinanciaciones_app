OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :scope => 'email,user_birthday', :display => 'popup', :provider_ignores_state => true

  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"],
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}
           },
            :scope => "email, profile, plus.me",
            :prompt => "select_account",
           }

end