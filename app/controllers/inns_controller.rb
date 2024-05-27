class InnsController < ApplicationController
  def show
    @inn = Inn.find(params[:id])
  end
end