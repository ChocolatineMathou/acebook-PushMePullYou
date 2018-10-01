require_relative '../../app/helpers/sign_up'
require_relative '../../app/helpers/make_post'

RSpec.configure do |config|
  config.include SignUpHelper
  config.include MakePostHelper
end

RSpec.feature 'Single view', type: :feature do
  scenario 'User can see a single post' do
    sign_up
    make_post
    click_button 'like'
    @post = Post.all[0]
    expect(@post.likes.count).to eq(1)
  end
end
