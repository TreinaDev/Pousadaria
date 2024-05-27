class InnDashboard::InnsController < InnDashboard::InnDashboardController
  def edit
    @inn.address ||= @inn.build_address
  end

  def update
    if @inn.update(inn_params)
      return redirect_to inn_management_path, notice: 'Pousada atualizada com sucesso.'
    end
    render :edit, status: :unprocessable_entity
  end

  private

  def inn_params
    params.require(:inn).permit(:description, :name, :registration_number, address_attributes: [:id, :postal_code, :address, :number, :neighborhood, :city, :state])
  end
end