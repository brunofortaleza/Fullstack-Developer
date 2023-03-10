class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :access, :dashboard

    @user_count = User.count
    @user_group = User.group(:role).count
  end
end
