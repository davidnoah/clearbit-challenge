require_relative '../clients/clearbit_client'

class Transaction
  attr_accessor :domain, :is_recurring, :logo
  attr_reader :name, :date, :amount

  def initialize(transaction)
    @name = transaction['name']
    @date = transaction['date']
    @amount = transaction['amount']
    @logo = nil
    @domain = nil
    @is_recurring = false
  end

  # This method takes a list of transactions, initializes a new Transaction instance, processes
  # the transactions through clearbit, and assesses whether the transaction is recurring or not
  def self.process_transactions(transactions)
    clearbit_processed_transactions = process_through_clearbit(transactions)

    check_for_recurrences(clearbit_processed_transactions)
  end

  def self.process_through_clearbit(transactions)
    domains = {}
    clearbit_client = ClearbitClient.new

    processed = transactions.map do |transaction|
      # Initialize a new instance of Transaction
      trans = create_new_transaction(transaction)

      # Check to see if the company domain has been processed already, if not make a request to 
      # the Clearbit name to domain API. Then set the domain and logo instance variables. if the
      # Clearbit API returns nil, set the domain hash to an empty object. This ensures that a request
      #  to Clearbit is never made twice for the same company
      domains[trans.name] ||= (clearbit_client.name_to_domain(trans.name) || {})

      if domains[trans.name]['domain']
        trans.domain = domains[trans.name]['domain']
        trans.logo = domains[trans.name]['logo']
      end

      trans
    end

    processed
  end

  def self.create_new_transaction(transaction)
    Transaction.new(transaction)
  end

  def self.check_for_recurrences(transactions)
    last_occurance = {}

    # Iterate through all transactions found
    processed = transactions.map do |transaction|
      # Identify whether the transaction is recurring. A recurring transaction here is defined
      # as a payment that occurs on the same day for the same amount of money over consecutive
      # months. First parse the date into a Ruby date object and create an identifier. Check to 
      # see if we have seen a payment with the same identifier, then check to see if that payment
      # occured one month previously. If so, change both the last_occurance and current transaction
      # to recurring. O(n)
      date = DateTime.parse(transaction.date)
      transaction_identifier = "#{transaction.name}_#{date.day}_#{transaction.amount}"

      last_trans = last_occurance[transaction_identifier]
      # The use of strftime here ensures that no two months are treated the same
      if last_trans && DateTime.parse(last_trans.date).strftime("%Y-%m") == date.next_month.strftime("%Y-%m")
        last_trans.is_recurring = true
        transaction.is_recurring = true
      end

      last_occurance[transaction_identifier] = transaction

      transaction
    end

    processed
  end
end