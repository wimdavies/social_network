# {{posts}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

```
Table: posts

Columns:
id | title | content | number_of_views | post_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- 
-- (file: spec/posts_seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, number_of_views, post_id) VALUES ('Birthday', '30 today!', 15, 1);
INSERT INTO posts (title, content, number_of_views, post_id) VALUES ('Funeral', 'Dead today!', 30, 1);
INSERT INTO posts (title, content, number_of_views, post_id) VALUES ('Off to the shops', 'Got some beans', 500, 2);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :number_of_views, :post_id
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # creates a new record
  # one argument: the Post model 
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);

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
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# 1
# Get all posts
repo = PostRepository.new

posts = repo.all

posts.length # =>  3

posts[0].id # =>  '1'
posts[0].title # =>  'Birthday'
posts[0].contents # =>  '30 today!'
posts[0].number_of_views # =>  '15'
posts[0].user_account_id # =>  '1'

posts[1].id # =>  '2'
posts[1].title # =>  'Funeral'
posts[1].contents # =>  'Dead today!'
posts[1].number_of_views # =>  '30'
posts[1].user_account_id # =>  '1'

posts[2].id # =>  '3'
posts[2].title # =>  'Off to the shops'
posts[2].contents # =>  'Got some beans'
posts[2].number_of_views # =>  '500'
posts[2].user_account_id # =>  '2'

# 2
# Get a single post
repo = PostRepository.new

post = repo.find(1)

post.id # =>  '1'
post.title # =>  'Birthday'
post.contents # =>  '30 today!'
post.number_of_views # =>  '15'
post.user_account_id # =>  '1'

# 3
# create a new post
repo = PostRepository.new

post = Post.new
post.title = 'test post'
post.contents = 'please ignore'
post.number_of_views = 1
post.user_account_id = 3

repo.create(post) # returns nothing

posts = repo.all

post = posts.last

post.id # => '4'
post.title # => 'test post'
post.contents # => 'please ignore'
post.number_of_views # => '1'
post.user_account_id # => '3'

# 4 
# deletes a post
repo = PostRepository.new

repo.delete(1) # => nil

posts = repo.all

post = posts.first

post.id # =>  '2'
post.title # =>  'Funeral'
post.contents # =>  'Dead today!'
post.number_of_views # =>  '30'
post.user_account_id # =>  '1'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/posts_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_table' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._