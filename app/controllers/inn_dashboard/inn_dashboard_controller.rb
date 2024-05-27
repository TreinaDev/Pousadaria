class InnDashboard::InnDashboardController < ApplicationController
  before_action :authenticate_inn_owner!
  before_action :set_current_inn

  private
  def set_current_inn
    @inn = current_inn_owner.inn
  end
end