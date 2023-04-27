require_relative './post.rb'
require_relative './database_connection.rb'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts;
    sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts;'

    results = DatabaseConnection.exec_params(sql, [])
    
    # Returns an array of Post objects.
    posts = []

    results.each do |record|
      post = Post.new

      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.number_of_views = record['number_of_views']
      post.user_account_id = record['user_account_id']

      posts << post
    end

    return posts
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;
    sql = 'SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;'
    
    result = DatabaseConnection.exec_params(sql, [id])
    
    # Returns a single Post object.
    record = result[0]

    post = Post.new

    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.number_of_views = record['number_of_views']
    post.user_account_id = record['user_account_id']

    return post
  end

  # creates a new record
  # one argument: the Post model 
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);
    sql = 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);'
    params = [post.title, post.content, post.number_of_views, post.user_account_id]
    
    DatabaseConnection.exec_params(sql, params)

    # Returns nothing
    return nil
  end

  # def update(post)
  # end

  # deletes a given record
  # one argument: the record to delete
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;
    sql = 'DELETE FROM posts WHERE id = $1;'

    DatabaseConnection.exec_params(sql, [id])

    # returns nothing
    return nil
  end
end