require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user, :admin) }

  before do
    sign_in user
    allow(controller).to receive(:authorize!).and_return(true)
  end

  describe "GET #index" do
    it "authorizes access" do
      expect(controller).to receive(:authorize!).with(:access, :dashboard)
      get :index
    end

    it "requires authentication" do
      sign_out user
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
