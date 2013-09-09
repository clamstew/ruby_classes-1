class RaceTrack
  require 'money'
  attr_accessor :racecars, :attendees

  def initialize(name = nil)
    @racecars = []
    @track_name = name
    @total_race_time = 0
    @race_started = false
    @betting_odds
    @attendees = []
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
    @betting_odds = rand(0.0..1.0)
  	puts "-------- THE RACE HAS STARTED! --------"
    puts "People in attendance are: "
    @attendees.each do |person|
      puts "#{person.name} is here."
    end
  	@total_race_time = 1 # when you start the race 1 hour is added to the race time
    # then each car drives at the speed they were initialized at
    # and their speed is increased
    @racecars.each do |car|
      current_distance = car.speed
      car.total_distance = car.total_distance + current_distance
      puts "#{car.name} has traveled #{car.total_distance} miles (going at a speed of #{car.speed})"
      car.speed = car.speed + rand(0..20)
    end
    puts "========= The race started and has been advanced to #{@total_race_time} hour. The current betting odds are #{@betting_odds}. ========="
  end

  def add_hour_to_race
  	@total_race_time = @total_race_time + 1
    @betting_odds = rand(0.0..1.0) # can change this to a function that changes the odds depending who is first by name or somerhing
  	if @total_race_time < 5
  	  @racecars.each do |car|
  	    current_distance = car.speed
  	    car.total_distance += current_distance
  	    puts "#{car.name} has traveled #{car.total_distance} miles (going at a speed of #{car.speed})"
  	    car.speed = car.speed + rand(0..20)
  	  end
  	  puts "========= The race has been going on for #{@total_race_time} hours. The current betting odds are #{@betting_odds}. ========="
    elsif @total_race_time == 5
      puts "========= The race has reached 5 hours and has ended.  Here are the standings: ========="
      @racecars.each do |car|
      	car.speed = 0
      	puts "#{car.name} - #{car.total_distance} | current speed: #{car.speed}"
      end
      @race_started = false
      self.print_places
    end
    calculate_each_user_total_for_one_hour(@betting_odds)
  end

  def calculate_each_user_total_for_one_hour(current_odds)
    current_standings = @racecars.sort{ |a,b| b.total_distance <=> a.total_distance }
    puts "The current winner is #{current_standings[0].name}!"
    @attendees.each do |person|
      if person.current_car_betting_on == current_standings[0]
        person.winnings += (person.current_bet_amount * current_odds)
      end
    end
  end

  def print_places
    # used this link to figure out sort: http://ariejan.net/2007/01/28/ruby-sort-an-array-of-objects-by-an-attribute/
  	@racecars.sort!{ |a,b| b.total_distance <=> a.total_distance }
  	place = 1
  	@racecars.each do |car|
  	  puts "place #{place}: #{car.name}"
  	  puts "Winner!" if place == 1
  	  place += 1
  	end
  end

  def determine_payout
    puts "THE PAYOUT: "
    @attendees.each do |person|
      puts "#{person.name} won $#{Money.new(person.winnings, "USD")}."
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

class User
  require 'money'
  attr_accessor :name, :winnings, :current_car_betting_on, :current_bet_amount

  def initialize(name, racetrack_attending)
    @name = name
    @current_bet_amount = 0
    @winnings = 0
    racetrack_attending.attendees << self
    @current_car_betting_on
  end

  def place_bet(amount, car)
    @current_bet_amount = amount
    @current_car_betting_on = car
    puts "#{@name} places a bet of $#{Money.new(amount, "USD")} on #{car.name}."
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

# make users
user_1 = User.new("Jake", talledaga)
user_2 = User.new("Amy", talledaga)
user_3 = User.new("Blake", talledaga)

talledaga.start_race # this will set the race at 1 hour
# get users to place bets here
user_1.place_bet(1000, car_a)
user_2.place_bet(2000, car_a)
user_3.place_bet(3000, car_b)

talledaga.add_car(car_d) # should not allow this car to add to track since the race has started

talledaga.add_hour_to_race # should be 2 hours
# get users to place bets here
user_1.place_bet(4000, car_c)
user_2.place_bet(3400, car_b)
user_3.place_bet(10000, car_a)
talledaga.add_hour_to_race # should be 3 hours
# get users to place bets here
user_1.place_bet(4500, car_a)
user_2.place_bet(3000, car_b)
user_3.place_bet(100, car_c)
talledaga.add_hour_to_race # should be 4 hours
# get users to place bets here
user_1.place_bet(500, car_c)
user_2.place_bet(3200, car_a)
user_3.place_bet(2000, car_b)
talledaga.add_hour_to_race # should be 5 hours and end the race here

talledaga.determine_payout

# =========================================================================
# start exercise 45
# Gambling in racecar driving
#
# Racing is cool, but gambling makes it a ton more interesting!
#
# - Creating a betting system that allows you to bet at the beginning of every hour of the race.
# - The odds should change depending on who is ahead. -- NOT SURE HOW TO DO THIS PART
# - At the end of the race, determine a payout amount for every user


