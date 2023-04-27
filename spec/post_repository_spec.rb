require 'post.rb'
require 'post_repository.rb'
require 'database_connection'


def reset_posts_table
  seed_sql = File.read('spec/posts_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  context '#all' do
    it 'returns all the posts' do
      repo = PostRepository.new

      posts = repo.all

      expect(posts.length).to eq 3

      expect(posts[0].id).to eq '1'
      expect(posts[0].title).to eq 'Birthday'
      expect(posts[0].content).to eq '30 today!'
      expect(posts[0].number_of_views).to eq '15'
      expect(posts[0].user_account_id).to eq '1'

      expect(posts[1].id).to eq '2'
      expect(posts[1].title).to eq 'Funeral'
      expect(posts[1].content).to eq 'Dead today!'
      expect(posts[1].number_of_views).to eq '30'
      expect(posts[1].user_account_id).to eq '1'

      expect(posts[2].id).to eq '3'
      expect(posts[2].title).to eq 'Off to the shops'
      expect(posts[2].content).to eq 'Got some beans'
      expect(posts[2].number_of_views).to eq '500'
      expect(posts[2].user_account_id).to eq '2'
    end
  end

  context '#find' do
    it 'returns the first post' do
      repo = PostRepository.new

      post = repo.find(1)

      expect(post.id).to eq '1'
      expect(post.title).to eq 'Birthday'
      expect(post.content).to eq '30 today!'
      expect(post.number_of_views).to eq '15'
      expect(post.user_account_id).to eq '1'
    end
  end

  context '#create' do
    it 'creates a new post' do
      repo = PostRepository.new

      post = Post.new
      post.title = 'test post'
      post.content = 'please ignore'
      post.number_of_views = 1
      post.user_account_id = 3

      repo.create(post)

      posts = repo.all

      post = posts.last

      expect(post.id).to eq '4'
      expect(post.title).to eq 'test post'
      expect(post.content).to eq 'please ignore'
      expect(post.number_of_views).to eq '1'
      expect(post.user_account_id).to eq '3'
    end
  end

  context '#delete' do
    it 'deletes the first post' do
      repo = PostRepository.new

      repo.delete(1) # => nil

      posts = repo.all

      post = posts.first

      expect(post.id).to eq '2'
      expect(post.title).to eq 'Funeral'
      expect(post.content).to eq 'Dead today!'
      expect(post.number_of_views).to eq '30'
      expect(post.user_account_id).to eq '1'
    end
  end
end