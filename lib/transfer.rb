require 'pry'
class Transfer
  attr_accessor :status, :sender, :receiver, :amount, :bankaccount
  def initialize(sender, receiver, amount = 50)
    @status = 'pending'
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end


  def execute_transaction
    if valid? && @status =="pending"
      if amount < @sender.balance
      @sender.balance = @sender.balance - @amount
      @receiver.balance = @receiver.deposit(@amount)
      @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end


  def reverse_transfer
    if @status == "complete"
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = "reversed"
    end
  end
end
