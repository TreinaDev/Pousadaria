class InnManagementsController < ApplicationController

  def show
    @inn = current_inn_owner.inn if inn_owner_signed_in?
  end
end