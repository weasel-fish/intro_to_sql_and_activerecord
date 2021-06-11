RSpec.describe "Query" do 
  describe ".run(query)" do 
    it "takes a query as an argument and executes the query on the database object" do 
      db = Query.class_variable_get("@@db")
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
      expect(column_names).to include("artist_id")
    end
  end


end