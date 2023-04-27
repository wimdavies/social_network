# {{user_accounts}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).


```
Table: user_accounts

Columns:
id | username | email_address
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (username, email_address) VALUES ('David', 'dave@aol.com');
INSERT INTO user_accounts (username, email_address) VALUES ('Anna', 'anna@aol.com');
INSERT INTO user_accounts (username, email_address) VALUES ('Will', 'will@aol.com');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount
end

# Repository class
# (in lib/user_accounts_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email_address
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts;

    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts WHERE id = $1;

    # Returns a single UserAccount object.
  end

  # creates a new record
  # one argument: the UserAccount model 
  def create(user_account)
    # Executes the SQL query:
    # INSERT INTO user_accounts (username, email_address)
    #   VALUES ($1, $2)
    #   ;

    # Returns nothing
  end

  # def update(user_account)
  # end

  # deletes a given record
  # one argument: the record to delete
  def delete(user_account)
    # Executes the SQL query:
    # DELETE FROM user_accounts WHERE id = $1;

    # returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all user_accounts
repo = UserAccountRepository.new

user_accounts = repo.all

user_accounts.length # =>  3

user_accounts[0].id # =>  '1'
user_accounts[0].username # =>  'David'
user_accounts[0].email_address # =>  'dave@aol.com'

user_accounts[1].id # =>  '2'
user_accounts[1].username # =>  'Anna'
user_accounts[1].email_address # =>  'anna@aol.com'

user_accounts[2].id # =>  '3'
user_accounts[2].username # =>  'Will'
user_accounts[2].email_address # =>  'will@aol.com'


# 2
# Get a single user_account
repo = UserAccountRepository.new

user_account = repo.find(1)

user_account.id # =>  '1'
user_account.username # =>  'David'
user_account.email_address # =>  'dave@aol.com'

# 3
# create a new user_account
repo = UserAccountRepository.new

user_account = UserAccount.new
user_account.username = 'Alice'
user_account.email_address = 'alice@hotmail.co.uk'

repo.create(user_account) # returns nothing

user_accounts = repo.all

user_account = user_accounts.last

user_account.id # => '4'
user_account.username # => 'Alice'
user_account.email_address # => 'alice@hotmail.co.uk'

# 4 
# deletes a user_account
repo = UserAccountRepository.new

repo.delete(1) # => nil

user_accounts = repo.all

user_account = user_accounts.fist

user_account.id # => '2'
user_account.username # => 'Anna'
user_account.email_address # => 'anna@aol.com'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/user_accounts_repository_spec.rb

def reset_user_accounts_table
  seed_sql = File.read('spec/user_accounts_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe UserAccountsRepository do
  before(:each) do 
    reset_user_accounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._