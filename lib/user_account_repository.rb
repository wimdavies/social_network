class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts;
    sql = 'SELECT id, username, email_address FROM user_accounts;'
    
    results = DatabaseConnection.exec_params(sql, [])
    # Returns an array of UserAccount objects.
    user_accounts = []

    results.each do |record|
      user_account = UserAccount.new

      user_account.id = record['id']
      user_account.username = record['username']
      user_account.email_address = record['email_address']

      user_accounts << user_account
    end

    return user_accounts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address FROM user_accounts WHERE id = $1;
    sql = 'SELECT id, username, email_address FROM user_accounts WHERE id = $1;'

    result = DatabaseConnection.exec_params(sql, [id])

    # Returns a single UserAccount object.
    user_account = UserAccount.new

    record = result[0]

    user_account.id = record['id']
    user_account.username = record['username']
    user_account.email_address = record['email_address']

    user_account
  end

  # creates a new record
  # one argument: the UserAccount model 
  def create(user_account)
    # Executes the SQL query:
    # INSERT INTO user_accounts (username, email_address) VALUES ($1, $2);
    sql = 'INSERT INTO user_accounts (username, email_address) VALUES ($1, $2);'
    params = [user_account.username, user_account.email_address]

    DatabaseConnection.exec_params(sql, params)

    # Returns nothing
    return nil
  end

  # def update(user_account)
  # end

  # deletes a given record
  # one argument: the record to delete
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM user_accounts WHERE id = $1;
    sql = 'DELETE FROM user_accounts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)

    # returns nothing
    return nil
  end
end