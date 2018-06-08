require 'clearbit'

class ClearbitClient
  def initialize
    Clearbit.key = ENV['CLEARBIT_API_KEY']
  end

  def name_to_domain(name)
    Clearbit::NameDomain.find(name: name)
  end

  # def transactions_to_domains(transactions)
  #   domains = {}
  #   transactions.each do |transaction|
      
  #   end
  # end
end