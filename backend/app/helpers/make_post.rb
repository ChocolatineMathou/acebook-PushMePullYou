# frozen_string_literal: true

module MakePostHelper
  def make_post
    visit "/posts"
    fill_in "post_message", with: "test post"
    click_button "Submit"
  end
end
