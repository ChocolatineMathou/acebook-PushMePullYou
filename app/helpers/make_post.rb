module MakePostHelper
  def make_post
    visit '/posts/new'
    fill_in 'post_message', with: 'test post'
    click_button 'Submit'
  end
end
