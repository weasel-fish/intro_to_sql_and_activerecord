RSpec.describe "Query" do 
  before(:all) do 
    Query::DB.execute("DROP TABLE IF EXISTS fans")
  end
  @@your_name = "Dakota"
  describe ".run(query)" do 
    it "takes a query as an argument and executes the query on the database object" do 
      db = Query::DB
      expect(db).to receive(:execute).with("SELECT * FROM Artist")
      Query.run("SELECT * FROM Artist")
    end
  end

  describe ".all_artists_query" do 
    it "returns the SQL query that retrieves all of the Artists in the DB" do
      result = Query.run(:all_artists_query)
      expect(result.length).to eq(275)
      expect(result.first).to eq({"ArtistId" => 1, "Name" => "AC/DC"})
      expect(result.last).to eq({"ArtistId" => 275, "Name" => "Philip Glass Ensemble"})
    end
  end

  describe ".black_sabbath_query" do 
    it "returns the SQL query that retrieves the black sabbath artist from the db" do 
      result = Query.run(:black_sabbath_query)
      expect(result).to eq([{
        "ArtistId" => 12, "Name" => "Black Sabbath"
      }])
    end
  end

  describe ".create_fans" do 
    it "returns a SQL query that creates the 'fans' table (if it doesn't already exist) that has an autoincrementing id column (integer) as a primary key and a name column (string)" do 
      Query.run(:create_fans)
      expect(Query.run("SELECT * FROM fans")).to be_a(Array)
    end

  end

  describe ".add_artist_id_to_fans" do 
    it "adds an artist_id integer foreign key to the fans table" do 
      column_names = Query.run("PRAGMA table_info(fans)").map{|col_data| col_data["name"]}
      Query.run(:add_artist_id_to_fans) unless column_names.include?("artist_id")
      updated_column_names = Query.run("PRAGMA table_info(fans)").map{|col_data| col_data["name"]}
      expect(updated_column_names).to include("artist_id")
    end
  end

  describe ".make_yourself_a_fan_of_the_black_eyed_peas" do 
    it "adds your name to the fans table as a fan of the black eyed peas (ArtistId **169**)" do 
      Query.run(:make_yourself_a_fan_of_the_black_eyed_peas)
      black_eyed_peas_fans = Query.run("SELECT * FROM fans WHERE artist_id = 169").map{|row| row["name"]}
      expect(black_eyed_peas_fans).to include(Query.your_name)

    end

  end

  describe ".update_your_name_in_fans" do 
    it "updates the name of the fan you just created(Query.your_name) to a new name" do 
      your_fan_id = Query.run("SELECT id FROM fans WHERE name = '#{Query.your_name}'").last["id"]
      Query.run(:update_your_name_in_fans)
      expect(Query.run("SELECT name FROM fans WHERE id = #{your_fan_id}").first["name"]).not_to eq(Query.your_name)
    end
  end

  describe "select_artist_name_and_album_title" do 
    it "returns an array of hashes containing album titles and the album artist's name HINT: need a JOIN and an AS clause for this" do 
      result = Query.run(:select_artist_name_and_album_title)
      expect(result.first).to eq({
        "artist_name" => "AC/DC",
        "album_title" => "For Those About To Rock We Salute You"
      })
      expect(result.last).to eq({
        "artist_name" => "Philip Glass Ensemble",
        "album_title" => "Koyaanisqatsi (Soundtrack from the Motion Picture)"
      })
    end
  end
  
  describe "select_artist_name_album_name_and_track_count" do 
    it "returns an array of hashes containing the artist's name, album_name and track_count for the album HINT: data spread over 3 tables, so you'll need multiple join statements and you also need to COUNT all tracks associated with an album. Because COUNT is an aggregate function, you may need to group first" do 
      puts "ANOTHER HINT: https://www.w3schools.com/sql/sql_groupby.asp could be helpful"
      results = Query.run(:select_artist_name_album_name_and_track_count)
      expect(results.first).to eq({
        "artist_name" => "AC/DC",
        "album_title" => "For Those About To Rock We Salute You",
        "track_count" => 10
      })
      expect(results.last).to eq({
        "artist_name" => "Philip Glass Ensemble",
        "album_title" => "Koyaanisqatsi (Soundtrack from the Motion Picture)",
        "track_count" => 1
      })
    end
  end


end