# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twitter_helloworld_session',
  :secret      => 'bfba1540db296fa2b05e1f57a940bf5e0c30017b974441d6344fb0a1965f3ad140775dfe829df29cfb6b089fa733e095125c0b3a04450c6e573a02ecf1db489a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
