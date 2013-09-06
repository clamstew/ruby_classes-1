# properties @position @gas_amount

# .setup -- sets position to 0 and 10 gallons

# drive method -- parameters: how many miles -- returns new position and gas_amount

# car fillup method -- prints out how much gas costs



class Car
	def initialize
		@fuel = 10
		@distance = 0
		puts "the initialize method is running automatically"
	end 

	def get_info
		"I'm a car. I've driven #{@distance} miles and have #{@fuel} gallons of gas left."
	end

	def drive(miles)
		@fuel = @fuel - (20.0 * miles)
		@distance = @distance + miles
	end
end