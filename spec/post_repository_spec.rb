require 'post.rb'
require 'post_repository.rb'
require 'database_connection'


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