require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "POST /" do
    it "responds with 200" do
      post :create, params: { post: { message: "Hello, world!" } }
      expect(response).to redirect_to(posts_url)
    end
  end

  describe "GET /" do
    it "responds with 302" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "DELETE /" do

    it "passes destroy method to Post" do
      expect(Post).to receive(:destroy).with("1")
      delete :destroy, params: { id: 1 }
    end

    it "responds with 302" do
      allow(Post).to receive(:destroy)
      delete :destroy, params: { id: 1 }
      expect(response).to have_http_status(302)
    end

    it "redirects to posts_url" do
      allow(Post).to receive(:destroy)
      delete :destroy, params: { id: 1}
      expect(response).to redirect_to(posts_url)
    end
  end

end
