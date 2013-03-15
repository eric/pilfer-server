# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# Skip missing secret check when precompiling assets.
if Rails.env.production? &&
   Rails.groups.exclude?('assets') &&
   ENV['SECRET_TOKEN'].blank?
  raise 'SECRET_TOKEN environment variable must be set!'
end


Pilfer::Application.config.secret_token =
  ENV['SECRET_TOKEN'] ||
  'a233f7b65530c2ba38932c7c7047971b8687a53023465ac82709a96bdbca1a6b6487d12dbee2588e2a5374c6584be2a83bf68f02cd70b0a025c14fb737f0474b'
