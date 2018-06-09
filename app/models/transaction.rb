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

  def self.process_transactions(transactions)
    domains = {}
    clearbit_client = ClearbitClient.new
    last_occurance_month = {}

    processed_transactions = transactions.map do |transaction|
      trans = Transaction.new(transaction)
      date = DateTime.parse(trans.date)

      domains[trans.name] ||= clearbit_client.name_to_domain(trans.name)
      if domains[trans.name]
        trans.domain = domains[trans.name]['domain']
        trans.logo = domains[trans.name]['logo']
      end

      transaction_identifier = "#{trans.name}_#{date.day}_#{trans.amount}"
      
      if last_occurance_month[transaction_identifier] == date.month + 1
        trans.is_recurring = true
      end

      last_occurance_month[transaction_identifier] = date.month

      trans
    end

    last_occurance_month = {}
    processed_transactions.reverse_each do |trans|
      date = DateTime.parse(trans.date)
      transaction_identifier = "#{trans.name}_#{date.day}_#{trans.amount}"

      if last_occurance_month[transaction_identifier] == date.month - 1
        trans.is_recurring = true
      end

      last_occurance_month[transaction_identifier] = date.month
    end

    processed_transactions
  end
end