# OTHER REQUIREMENTS:
#
# Make sure the balance never drops below 0. 
# If it does, prevent the transaction and charge a $10 fee... because we're a bank and we can!
# 
# Create a method called, add monthly interest. This should add 1.5% interest to the credit card bill (multiply by 1.015). This will also give back interest on the user's bank balance. Let's give them 0.03% interest for the balance they have.


class BankAccount
  require 'money'

  def initialize
  	puts "What is your first name?"
    @first_name = gets.chomp
    puts "What is your last name?"
    @last_name = gets.chomp
    @balance = 0 # in pennies
    @credit_card_debt = 0 # in pennies
    balance = Money.new(@balance, "USD")
	cc_debt = Money.new(@credit_card_debt, "USD")
    puts "Congrats. You just set up a bank account for #{@first_name} #{@last_name}. Your current balance is $#{balance}. Your Credit Card debt is $#{cc_debt}."
  end

  def statement
  	balance = Money.new(@balance, "USD")
	cc_debt = Money.new(@credit_card_debt, "USD")
  	puts "Welcome #{@first_name} #{@last_name} to WellFargo Banking. Your current balance is $#{balance}. Your Credit Card debt is $#{cc_debt}."
  end

  def deposit
  	puts "How much are you depositing into your account (in pennies)?"
  	amount = gets.chomp
  	@balance = @balance + amount.to_i
  	puts "Your current balance is $#{Money.new(@balance, "USD")}. You just deposited $#{Money.new(amount, "USD")}."
  end

  # @todo: need to make sure there is something with either can't withdraw more than amount in @balance
  # or there is some sort of error message about overdrafting
  def withdraw
  	puts "How much are you withdrawing from your account (in pennies)?"
  	amount = gets.chomp
  	overdraft_fee = 1000
  	if @balance >= 0 && @balance - amount.to_i >= 0
  	  @balance = @balance - amount.to_i
  	  puts "Your current balance is $#{Money.new(@balance, "USD")}. You just withdrew $#{Money.new(amount, "USD")}."
  	else 
  	  puts "You cannot with withdraw more than your current balance.  You requested to withdraw #{Money.new(amount, "USD")} and your balance is only $#{Money.new(@balance, "USD")}. We just charged you at $#{Money.new(overdraft_fee, "USD")} fee for attempting to overdraft your account.  Your account now has a balance of $#{Money.new((@balance - overdraft_fee), "USD")}."
  	  @balance = @balance - overdraft_fee
  	end
  end

  # method to buy something with your credit card
  def buy_cc
  	puts "How much are you putting on your Credit Card (in pennies)?  Unfortunately, for you there is no spending limit, so use this at your own risk."
  	amount = gets.chomp.to_i
  	@credit_card_debt = @credit_card_debt + amount
  	puts "Your current credit card debt is $#{Money.new(@credit_card_debt, "USD")}.  You just put $#{Money.new(amount, "USD") } on your card."
  	# @todo: could add a if/else here to add a fee if someone uses more on cc than in balance
  end

  # method to pay off all or part of your CC bill
  def pay_cc_bill
  	puts "Would you like to pay your credit card bill from your bank account balance? (type 'yes' or 'no', NOTE: There is no way to pay part of your balance at this time.)"
  	answer = gets.chomp
  	if answer == "yes"
  	  if @balance >= 0 && @balance - @credit_card_debt >= 0
  	    @balance = @balance - @credit_card_debt
  	    @credit_card_debt = 0
  	    puts "Your Credit Card debt of #{Money.new(@credit_card_debt, "USD")} has been paid off."
  	  else
  	  	puts "Your balance was not great enough to pay off your credit card debt.  Try depositing more money."
  	  end
  	else
  	  puts "Pay off Credit Card transaction has been cancelled."
  	end
  	self.statement # print out a statement
  end

  def add_monthly_interest
  	@credit_card_debt = (@credit_card_debt * 1.015)
  	@balance = (@balance * 1.0003)
  	self.statement
  end
end
























