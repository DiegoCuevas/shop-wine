require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  def valid_attributes
    { name:"user1", email: "test@mail.com" }
  end

  describe "GET index" do
    it "index response ok" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = User.create! valid_attributes
      get :show, params: {id: user.to_param}
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "redirects to the user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to have_http_status(:ok)
      end
    end
   
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end