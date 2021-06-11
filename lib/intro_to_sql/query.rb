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
      SELECT * FROM Artist
    SQL
  end

  # write a query that returns the black sabbath artist
  def self.black_sabbath_query
    <<-SQL
      SELECT * FROM Artist WHERE name = 'Black Sabbath'
    SQL
  end

  # write a query that creates a table named 'fans' with an autoincrementing ID that's a primary key and a name column of type text. HINT: If you make a mistake here and need to try again, you'll want to drop into ./bin/console and do Query.run("DROP TABLE IF EXISTS 'fans'") first.
  def self.create_fans
    <<-SQL
      CREATE TABLE IF NOT EXISTS fans(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL
      );
    SQL
  end

  # write the SQL to alter the fans table to have a artist_id column type integer?
  def self.add_artist_id_to_fans
    <<-SQL
      ALTER TABLE fans
      ADD COLUMN artist_id INTEGER
    SQL
  end

  # Write the SQL to add yourself as a fan of the Black Eyed Peas? ArtistId **169**
  def self.make_yourself_a_fan_of_the_black_eyed_peas
    <<-SQL
      INSERT INTO fans(name, artist_id)
      VALUES("Dakota", 169)
    SQL
  end

  # write a SQL query to update your name in the fans table
  def self.update_your_name_in_fans
    <<-SQL
      UPDATE fans
      SET name = "Sandra"
      WHERE name = "Dakota"
    SQL
  end

  # write the SQL to display an artists name next to their album title
  def self.select_artist_name_and_album_title
    <<-SQL
      SELECT 
        Title AS album_title, 
        Name AS artist_name 
      FROM Album 
      INNER JOIN Artist ON Album.ArtistId = Artist.ArtistId
    SQL
  end

  # write the SQL to display artist name, album name and number of tracks on that album
  def self.select_artist_name_album_name_and_track_count
    <<-SQL
      SELECT 
        Artist.Name AS artist_name, 
        Title AS album_title, 
        COUNT(trackId) AS track_count
      FROM Artist 
      INNER JOIN Album ON Album.ArtistId = Artist.ArtistId
      INNER JOIN Track ON Track.AlbumId = Album.AlbumId
      GROUP BY Track.AlbumId
    SQL
  end

end