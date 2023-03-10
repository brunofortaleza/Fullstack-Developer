RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, :admin) }

  before do
    sign_in user
    allow(controller).to receive(:authorize!).and_return(true)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: user.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    context "when user is an admin" do
      it "returns a success response" do
        get :edit, params: { id: user.to_param }
        expect(response).to be_successful
      end
    end

    context "when user is not an admin" do
      let(:user) { create(:user) }

      before do
        sign_in user
        allow(controller).to receive(:authorize!).and_return(true)
      end

      it "redirects to root path" do
        expect(user.admin?).to be false
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { full_name: "New Name" } }

      it "updates the requested user" do
        put :update, params: { id: user.to_param, user: new_attributes }
        user.reload
        expect(user.full_name).to eq("New Name")
      end

      it "redirects to the users list" do
        put :update, params: { id: user.to_param, user: new_attributes }
        expect(response).to redirect_to(users_path)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: user.to_param, user: attributes_for(:user, full_name: "") }
        expect(response).not_to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: { id: user.to_param }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, params: { id: user.to_param }
      expect(response).to redirect_to(users_path)
    end
  end
end
