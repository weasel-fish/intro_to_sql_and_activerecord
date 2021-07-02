require "active_record"

ActiveRecord::Base.establish_connection(
  database: 'db/Chinook_Sqlite.sqlite',
  adapter: 'sqlite3'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

## Add any classes you want to work with below