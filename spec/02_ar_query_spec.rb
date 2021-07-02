require "intro_to_sql/ar_queries"

RSpec.describe "ActiveRecord queries" do 
  before(:all) do 
    Fan.destroy_all
  end
  describe "all_artists" do 
    it "returns an ActiveRecord::Relation containing all Artists" do 
      expect(all_artists).to be_a(ActiveRecord::Relation)
      expect(all_artists.length).to eq(275)
      expect(all_artists.first).to be_an(Artist)
    end
  end
  
  describe "make_yourself_a_fan_of_metallica" do 
    it "creates a new fan with your name and a reference to the metallica artist (check the artists table to find the correct foreign key and make sure to update the NAME constant to match your name)" do
      make_yourself_a_fan_of_metallica
      fan = Fan.last
      expect(fan.artist_id).to eq(50)
      expect(fan.name).to eq(NAME)
    end
  end

  describe "change_yourself_to_be_a_fan_of_led_zeppelin" do 
    it "updates the fan object created in the previous test to now be a fan of Led Zeppelin. (Again, check the artists table to find the correct foreign key)." do
      fan = Fan.where(name: NAME, artist_id: 50).last
      change_yourself_to_be_a_fan_of_led_zeppelin
      expect(fan).to exist, "Fan was not found. Make sure that you've updated the NAME constant to match the name you're giving the new Fan."
      fan.reload
      expect(fan.artist_id).to eq(22)
    end
  end

  describe "remove_yourself_as_a_fan" do 
    it "removes the fan object updated in the previous test"  do 
      fan = Fan.where(name: NAME, artist_id: 22).last
      expect(fan).to exist, "No fan was found. Make sure that you've updated the NAME constant to match the name used in your method calls."
      remove_yourself_as_a_fan
      expect(Fan.all).not_to include(fan)
    end
  end
end

