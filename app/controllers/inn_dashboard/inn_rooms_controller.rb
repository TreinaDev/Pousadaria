class InnDashboard::InnRoomsController < InnDashboard::InnDashboardController
  def new
    @inn_room = @inn.inn_rooms.build
  end

  def create
    @inn_room = @inn.inn_rooms.build(room_params)
    if @inn_room.save
      return redirect_to inn_management_path, notice: 'Quarto cadastrado com sucesso'
    end
    render :new, status: :unprocessable_entity
  end

  def show
    @inn_room = @inn.inn_rooms.find(params[:id])
  end

  def edit
    @inn_room = @inn.inn_rooms.find(params[:id])
  end

  def update
    @inn_room = @inn.inn_rooms.find(params[:id])
    if @inn_room.update(room_params)
      return redirect_to inn_dashboard_inn_room_path(@inn_room), notice: 'Quarto atualizado com sucesso'
    end
    render :edit, status: :unprocessable_entity
  end

  private

  def room_params
    params.require(:inn_room).permit(:name, :size, :guest_limit, :daily_rate_cents, :photo)
  end
end