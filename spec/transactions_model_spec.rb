require "rspec"
require_relative "../app/models/transaction"

describe "TransactionsModel" do
  before do
    allow_any_instance_of(ClearbitClient).to receive(:name_to_domain).and_return({"name"=>"CompanyName", "domain"=>"www.domain.com", "logo"=>"https://logo.clearbit.com/logo.com"})
  end

  def model_and_check_if_recurring(transactions)
    modeled_transactions = transactions.map { |transaction| Transaction.create_new_transaction(transaction) }

    Transaction.check_for_recurrences(modeled_transactions)
  end

  def test_transactions
    [
      {'name' => 'Clearbit', 'date' => '2018-06-05', 'amount' => 82},
      {'name' => 'Clearbit', 'date' => '2018-05-05', 'amount' => 82}
    ]
  end

  it "Creates the proper instance methods on initialization" do
    transaction = Transaction.new({'name' => 'Clearbit', 'date' => '2018-06-05', 'amount' => 82})

    expect(transaction.name).to eq('Clearbit')
    expect(transaction.date).to eq('2018-06-05')
    expect(transaction.amount).to eq(82)
  end

  it "Processes each transaction through Clearbit" do
    transactions = test_transactions

    processed_transactions = Transaction.process_through_clearbit(transactions)

    expect(processed_transactions[0]).to be_instance_of(Transaction)
    expect(processed_transactions[0].logo).to eq("https://logo.clearbit.com/logo.com")
    expect(processed_transactions[0].domain).to eq("www.domain.com")
  end

  it "Only processes a company once through the Clearbit API" do
    expect_any_instance_of(ClearbitClient).to receive(:name_to_domain).once
    transactions = test_transactions

    processed_transactions = Transaction.process_through_clearbit(transactions)
  end

  it "Only processes a company once through the Clearbit API even when the Clearbit API returns nil" do
    allow_any_instance_of(ClearbitClient).to receive(:name_to_domain).and_return(nil)
    expect_any_instance_of(ClearbitClient).to receive(:name_to_domain).once
    transactions = test_transactions

    processed_transactions = Transaction.process_through_clearbit(transactions)
  end

  it "Flags a transaction as recurring if occurred on the same day and same amount as adjacent month" do
    transactions = test_transactions

    checked_transactions = model_and_check_if_recurring(transactions)

    expect(checked_transactions[0].is_recurring).to be(true)
    expect(checked_transactions[1].is_recurring).to be(true)
  end

  it "Is able to assess adjacent months as the year changes" do
    transactions = test_transactions

    checked_transactions = model_and_check_if_recurring(transactions)

    expect(checked_transactions[0].is_recurring).to be(true)
    expect(checked_transactions[1].is_recurring).to be(true)
  end

  it "Does not flag as recurring when the transactions are diferent amounts" do
    transactions = test_transactions
    transactions[0]['amount'] = 100

    checked_transactions = model_and_check_if_recurring(transactions)

    expect(checked_transactions[0].is_recurring).to be(false)
    expect(checked_transactions[1].is_recurring).to be(false)
  end

  it "Does not flag as recurring when the transactions are spaced by multiple months" do
    transactions = test_transactions
    transactions[0]['date'] = '2018-08-05'
    
    checked_transactions = model_and_check_if_recurring(transactions)

    expect(checked_transactions[0].is_recurring).to be(false)
    expect(checked_transactions[1].is_recurring).to be(false)
  end
end