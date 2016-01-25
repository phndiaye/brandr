
# The application's running environment
set :rails_env, 'production'

# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server 'ec2-52-91-155-86.compute-1.amazonaws.com', {
  roles: %w{web api},
  user: 'admin'
}
