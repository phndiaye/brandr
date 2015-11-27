namespace :db do
  task reseed: [:drop, :create, :migrate, :seed]
end
