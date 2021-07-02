class Query
  DB = SQLite3::Database.new("db/Chinook_Sqlite.sqlite", results_as_hash: true)

  def self.run(query)
    query_to_execute = query.is_a?(Symbol) ? self.send(query) : query
    if query_to_execute.blank?
      "Please add your SQL query to the appropriate method"
    else
      DB.execute(query_to_execute)
    end
  end

  def self.your_name
    @@name = "Dakota" # change this to your name so the specs can read it!
  end

  # write a query that returns all the artists in the database
  def self.all_artists_query
    <<-SQL
     SELECT * FROM artists;
    SQL
  end

  # write a query that creates a table named 'fans' with an autoincrementing ID that's a primary key and a name column of type text. HINT: If you make a mistake here and need to try again, you'll want to drop into ./bin/console and do Query.run("DROP TABLE IF EXISTS 'fans'") first.
  def self.create_fans
    <<-SQL
      CREATE TABLE fans (id INTEGER PRIMARY KEY, name TEXT);
    SQL
  end

  # write the SQL to alter the fans table to have a artist_id column type integer?
  def self.add_artist_id_to_fans
    <<-SQL
      ALTER TABLE fans ADD COLUMN artist_id INTEGER;
    SQL
  end

  # Write the SQL to add yourself as a fan of the Black Eyed Peas? artist_id **169**
  def self.make_yourself_a_fan_of_the_black_eyed_peas
    <<-SQL
      INSERT INTO fans(name, artist_id) VALUES("Dakota", 169);
    SQL
  end

  # write a SQL query to update your fan row so that you're a fan of Led Zeppelin **id of 22**
  def self.update_your_fan_to_be_a_fan_of_led_zeppelin
    <<-SQL
      UPDATE fans SET artist_id = 22 WHERE name = 'Dakota';
    SQL
  end

  # Write a SQL query to remove yourself as a fan of Led Zeppelin
  def self.remove_yourself_as_a_fan
    <<-SQL
     DELETE FROM fans WHERE name = 'Dakota';
    SQL
  end
end