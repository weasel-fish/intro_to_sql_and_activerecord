class Query
  DB = SQLite3::Database.new("db/Chinook_Sqlite.sqlite", results_as_hash: true)

  def self.run(query)
    query.is_a?(Symbol) ? DB.execute(self.send(query)) : DB.execute(query)
  end

  def self.your_name
    @@name = "Dakota" # change this to your name so the specs can read it!
  end

  # write a query that returns all the artists in the database
  def self.all_artists_query
    <<-SQL
      
    SQL
  end

  # write a query that returns the black sabbath artist
  def self.black_sabbath_query
    <<-SQL
      
    SQL
  end

  # write a query that creates a table named 'fans' with an autoincrementing ID that's a primary key and a name column of type text. HINT: If you make a mistake here and need to try again, you'll want to drop into ./bin/console and do Query.run("DROP TABLE IF EXISTS 'fans'") first.
  def self.create_fans
    <<-SQL
      
    SQL
  end

  # write the SQL to alter the fans table to have a artist_id column type integer?
  def self.add_artist_id_to_fans
    <<-SQL
      
    SQL
  end

  # Write the SQL to add yourself as a fan of the Black Eyed Peas? ArtistId **169**
  def self.make_yourself_a_fan_of_the_black_eyed_peas
    <<-SQL
      
    SQL
  end

  # write a SQL query to update your name in the fans table
  def self.update_your_name_in_fans
    <<-SQL
      
    SQL
  end

  # write the SQL to display an artists name next to their album title
  def self.select_artist_name_and_album_title
    <<-SQL
      
    SQL
  end

  # write the SQL to display artist name, album name and number of tracks on that album
  def self.select_artist_name_album_name_and_track_count
    <<-SQL
      
    SQL
  end

end