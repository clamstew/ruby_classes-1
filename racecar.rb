class RaceTrack
  attr_accessor :racecars

  def initialize(name = nil)
    @racecars = []
    @track_name = name
    @total_race_time = 0
    @race_started = false
    puts "Welcome to #{@track_name}! Are you ready to race?"
  end

  def add_car(car)
    if @race_started == false
  	  @racecars << car
  	  puts "#{car.name} has been added to the #{@track_name} race track."
  	else
  	  puts "ERROR: The race has started. Your car, #{car.name}, cannot be added at this time."
  	end
  end

  def start_race
  	@race_started = true
  	puts "-------- THE RACE HAS STARTED! --------"
  	@total_race_time = 1 # when you start the race 1 hour is added to the race time
    # then each car drives at the speed they were initialized at
    # and their speed is increased
    @racecars.each do |car|
      current_distance = car.speed
      car.total_distance = car.total_distance + current_distance
      puts "#{car.name} has traveled #{car.total_distance} miles (going at a speed of #{car.speed})"
      car.speed = car.speed + rand(0..20)
    end
    puts "========= The race started and has been advanced to #{@total_race_time} hour. ========="
  end

  def add_hour_to_race
  	@total_race_time = @total_race_time + 1
  	if @total_race_time < 5
  	  @racecars.each do |car|
  	    current_distance = car.speed
  	    car.total_distance = car.total_distance + current_distance
  	    puts "#{car.name} has traveled #{car.total_distance} miles (going at a speed of #{car.speed})"
  	    car.speed = car.speed + rand(0..20)
  	  end
  	  puts "========= The race has been going on for #{@total_race_time} hours. ========="
    elsif @total_race_time == 5
      puts "========= The race has reached 5 hours and has ended.  Here are the standings: ========="
      @racecars.each do |car|
      	car.speed = 0
      	puts "#{car.name} - #{car.total_distance} | current speed: #{car.speed}"
      end
      @race_started = false
      self.print_places
    end
  end

  def print_places
  	@racecars.sort!{ |a,b| b.total_distance <=> a.total_distance }
  	place = 1
  	@racecars.each do |car|
  	  puts "place #{place}: #{car.name}"
  	  puts "Winner!" if place == 1
  	  place += 1
  	end
  end
end

class RaceCar
  attr_accessor :name, :speed, :total_distance

  def initialize(name)
  	@name = name
  	@speed = rand(60..80)
  	@total_distance = 0
  	puts "This car has been initialized with a speed of #{@speed}mph."
  end
end


talledaga = RaceTrack.new('Talledaga SuperSpeedway')

car_a = RaceCar.new("Godaddy Car")
car_b = RaceCar.new("Michillin Car")
car_c = RaceCar.new("Penzoil Car")
car_d = RaceCar.new("Red Racecar")
talledaga.add_car(car_a)
talledaga.add_car(car_b)
talledaga.add_car(car_c)

talledaga.start_race # this will set the race at 1 hour
talledaga.add_car(car_d) # should not allow it since the race has started

talledaga.add_hour_to_race # should be 2 hours
talledaga.add_hour_to_race # should be 3 hours
talledaga.add_hour_to_race # should be 4 hours
talledaga.add_hour_to_race # should be 5 hours and end the race here




