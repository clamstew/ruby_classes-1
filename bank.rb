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
    puts "Congrats. You just set up a bank account for #{@first_name} #{@last_name}. Your current balance is $#{balance}. Your Credit Card debt is $#{cc_debt}"
  end

  def statement
  	balance = Money.new(@balance, "USD")
	cc_debt = Money.new(@credit_card_debt, "USD")
  	puts "Welcome #{@first_name} #{@last_name} to WellFargo Banking. Your current balance is $#{balance}. Your Credit Card debt is $#{cc_debt}"
  end

  def deposit
  	puts "How much are you depositing into your account (in pennies)?"
  	amount = gets.chomp
  	@balance = @balance + amount.to_i
  	puts "Your current balance is $#{Money.new(@balance, "USD")}. You just deposited $#{Money.new(amount, "USD")}"
  end

  # @todo: need to make sure there is something with either can't withdraw more than amount in @balance
  # or there is some sort of error message about overdrafting
  def withdraw
  	puts "How much are you withdrawing from your account (in pennies)?"
  	amount = gets.chomp
  	@balance = @balance - amount.to_i
  	puts "Your current balance is $#{Money.new(@balance, "USD")}. You just withdrew $#{Money.new(amount, "USD")}"
  end

  # method to buy something with your credit card
  def buy_cc
  end
end