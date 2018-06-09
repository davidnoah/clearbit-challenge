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
    last_occurance = {}

    processed_transactions = transactions.map do |transaction|
      trans = Transaction.new(transaction)

      domains[trans.name] ||= clearbit_client.name_to_domain(trans.name)
      if domains[trans.name]
        trans.domain = domains[trans.name]['domain']
        trans.logo = domains[trans.name]['logo']
      end

      date = DateTime.parse(trans.date)
      transaction_identifier = "#{trans.name}_#{date.day}_#{trans.amount}"

      last_trans = last_occurance[transaction_identifier]
      if last_trans && DateTime.parse(last_trans.date).strftime("%Y-%m") == date.next_month.strftime("%Y-%m")
        last_trans.is_recurring = true
        trans.is_recurring = true
      end

      last_occurance[transaction_identifier] = trans

      trans
    end

    processed_transactions
  end
end