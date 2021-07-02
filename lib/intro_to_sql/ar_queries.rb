NAME = "Kyle"

def all_artists
  Artist.all
end

# Use an ActiveRecord method to create a new fan with your name that has a foreign key pointing to Metallica (50)
def make_yourself_a_fan_of_metallica
  fan = Fan.new(name: "Kyle", artist_id: 50)
  fan.save
end

# Use an ActiveRecord method(s) to update the foreign key of the fan created by the last method
def change_yourself_to_be_a_fan_of_led_zeppelin
  kyle = Fan.find_by(name: "Kyle")
  kyle.artist_id = 22
  kyle.save
end

# Use ActiveRecord method(s) to find and delete the fan created by the last method
def remove_yourself_as_a_fan
    Fan.find_by(name: "Kyle").destroy
end