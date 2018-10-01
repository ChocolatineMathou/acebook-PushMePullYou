require_relative '../../app/helpers/sign_up'
require_relative '../../app/helpers/make_post'

RSpec.configure do |config|
  config.include SignUpHelper
  config.include MakePostHelper
end

RSpec.feature 'Like a post', type: :feature do

  before(:each) do
    sign_up
    make_post
    click_link 'Like'
    @post = Post.all[0]
  end

  scenario 'User like a single post' do
    expect(@post.likes.count).to eq(1)
  end

  scenario 'User can only like a post once' do
    click_link 'Like'
    expect(@post.likes.count).to eq(0)
  end
end
