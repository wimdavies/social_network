require 'user_account'
require 'user_account_repository'
require 'database_connection'

def reset_user_accounts_table
  seed_sql = File.read('spec/user_accounts_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe UserAccountsRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  context '#all' do
    xit 'returns list of all user_accounts' do
      repo = UserAccountRepository.new
      user_accounts = repo.all

      expect(user_accounts.length).to eq 3

      expect(user_accounts[0].id).to eq '1'
      expect(user_accounts[0].username).to eq 'David'
      expect(user_accounts[0].email_address).to eq 'dave@aol.com'

      expect(user_accounts[1].id).to eq '2'
      expect(user_accounts[1].username).to eq 'Anna'
      expect(user_accounts[1].email_address).to eq 'anna@aol.com'

      expect(user_accounts[2].id).to eq '3'
      expect(user_accounts[2].username).to eq 'Will'
      expect(user_accounts[2].email_address).to eq 'will@aol.com'
    end
  end
end