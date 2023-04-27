require_relative './post.rb'
require_relative './database_connection.rb'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, post_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, post_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # creates a new record
  # one argument: the Post model 
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, number_of_views, post_id) VALUES ($1, $2);

    # Returns nothing
  end

  # def update(post)
  # end

  # deletes a given record
  # one argument: the record to delete
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1;

    # returns nothing
  end
end