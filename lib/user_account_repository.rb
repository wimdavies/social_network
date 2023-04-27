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