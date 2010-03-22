# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CodeArchiver_session',
  :secret      => 'c150632e5407cc92755ba59bf7f0be33b68a9cf66ae46122273872605b745a40bec5c3288ae33c6c91cd52394b54e280445dc689e9f1fd15ee4f174b8f98dabc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
