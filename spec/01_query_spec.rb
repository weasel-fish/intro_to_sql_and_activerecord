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
      expect(result).to be_an(Array)
      expect(result.length).to eq(275)
      expect(result.first).to include({"id" => 1, "name" => "AC/DC"})
      expect(result.last).to include({"id" => 275, "name" => "Philip Glass Ensemble"})
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
    it "adds your name to the fans table as a fan of the black eyed peas (artist_id **169**)" do 
      Query.run(:make_yourself_a_fan_of_the_black_eyed_peas)
      black_eyed_peas_fans = Query.run("SELECT * FROM fans WHERE artist_id = 169").map{|row| row["name"]}
      expect(black_eyed_peas_fans).to include(Query.your_name)

    end

  end

  describe ".update_your_fan_to_be_a_fan_of_led_zeppelin" do 
    it "updates the artist_id of the fan you just created to point to Led Zeppelin" do 
      your_fan_id = Query.run("SELECT id FROM fans WHERE name = '#{Query.your_name}'").last["id"]
      Query.run(:update_your_fan_to_be_a_fan_of_led_zeppelin)
      expect(Query.run("SELECT name FROM fans WHERE id = #{your_fan_id}").first["name"]).to eq(Query.your_name)
      expect(Query.run("SELECT artist_id FROM fans WHERE id = #{your_fan_id}").first["artist_id"]).to eq(22)
    end
  end

  describe "remove_yourself_as_a_fan" do 
    it "removes the fan from the fans table" do 
      last_fan_id = Query.run("SELECT id FROM fans WHERE id = #{Query::DB.last_insert_row_id}").first[0]
      Query.run(:remove_yourself_as_a_fan)
      expect(Query.run("SELECT * FROM fans WHERE id = #{last_fan_id}")).to eq([])
    end
  end
end