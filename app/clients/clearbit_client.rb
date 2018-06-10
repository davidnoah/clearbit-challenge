require 'clearbit'

# Client class to handle initialization and queries to the Clearbit API
class ClearbitClient
  def initialize
    Clearbit.key = ENV['CLEARBIT_API_KEY']
  end

  # Queries the Clearbit name to domain API for a company's domain
  # @param {String} company_name - Name of the company
  # return {Object} - A response object with a company's name, logo and domain
  def name_to_domain(company_name)
    Clearbit::NameDomain.find(name: company_name)
  end
end