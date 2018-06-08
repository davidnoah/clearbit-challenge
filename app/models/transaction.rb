require_relative '../clients/clearbit_client'

class Transaction
  attr_accessor :domain

  def initialize(transaction)
    @transaction = transaction
    @domain = nil
    @is_recurring = nil
  end

  def name
    @transaction['name']
  end

  def self.process_transactions(transactions)
    domains = {}
    clearbit_client = ClearbitClient.new

    transactions.map do |transaction|
      trans = Transaction.new(transaction)

      domains[trans.name] ||= clearbit_client.name_to_domain(trans.name)
      trans.domain = domains[trans.name]

      trans
    end

  end
end