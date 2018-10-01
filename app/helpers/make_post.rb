module MakePostHelper
  def make_post
    visit '/posts/new'
  end
end
