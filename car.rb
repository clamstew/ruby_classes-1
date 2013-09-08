# properties @position @gas_amount

# .setup -- sets position to 0 and 10 gallons

# drive method -- parameters: how many miles -- returns new position and gas_amount

# car fillup method -- prints out how much gas costs



class Car
  require 'money'

  attr_reader :distance, :fuel

  def initialize
    @fuel = 10
    @distance = 0
    @money_spent = 0 # will save in pennies
    puts "the initialize method is running automatically"
  end 

  def get_info
    "I'm a car. I've driven #{@distance} miles and have #{@fuel} gallons of gas left. You have spent $#{Money.new((@money_spent), "USD")} in this car."
  end

  def drive(miles)
    if @fuel - (miles/20.0) > 0
      @fuel = @fuel - (miles/20.0)
      @distance = @distance + miles
      get_info
    else
      distance_traveled = @fuel * 20.0 # only go as far as the available fuel can go - fuel * 20 gives total number of miles
      @distance = @distance + distance_traveled # addes distance traveled with available fuel to @distance ivar
      miles_left_to_go = miles - distance_traveled # miles wanted to go minus miles went
      @fuel = 0
      puts "You're out of gas and need to fuel up. You drove #{distance_traveled} miles. You still need to go #{miles_left_to_go} to get to your destination."
      get_info
    end
  end

  # figures out how much gas you need to fill into order to reach a full tank at 10 gallons
  # after fill up can you tell me how much it costs at a rate of $3.50 / gallon
  def fuel_up 
  	gas_price = 350

  	if @fuel == 10
  	  puts "Your tank is topped off and cannot hold any more fuel"
  	elsif @fuel < 10 && @fuel > 0
  	  new_fuel = 10.0 - @fuel
  	  @fuel = 10 # set the fuel back at 10 so it is full

  	  dollars = Money.new((new_fuel * gas_price), "USD")
  	  @money_spent = @money_spent + (new_fuel * gas_price) # money spend will be in pennies


  	  puts "Gallons: #{new_fuel.round(3)}"
  	  puts "Total: $#{dollars}"
  	  puts "Total Money spent in this car $#{Money.new((@money_spent), "USD")}"
    end
  		
  end
end


=begin
	
if 10 - 10/20 <= 10
if 9.5 <= 10

if 10 - 20/20 <= 10
if 9 <= 10



if 10 - 190/20.0 <= 10
if 10 - 9.5 <= 10
if .5 <= 10
	
=end