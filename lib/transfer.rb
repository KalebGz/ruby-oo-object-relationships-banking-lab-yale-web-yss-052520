require 'pry'
class Transfer
  
  attr_reader :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    return true if(@receiver.valid? && @sender.valid?)
    false
  end

  def execute_transaction
    # binding.pry
    return 0 if(@status != "pending") # Each transfer can only happen once
    if(@receiver.status == "closed" || @sender.status == "closed" || @sender.balance < amount)
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    else
      @sender.deposit(-@amount)
      @receiver.deposit(amount)
      @status = "complete"
    end
  end

  def reverse_transfer
      if(@status == "complete")
      @sender.deposit(@amount)
      @receiver.deposit(-amount)
      @status = "reversed"
    end
  end
end
