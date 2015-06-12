class Admin::PositionsController < ApplicationController
  before_action :set_position

  def index
    @positions = Position.all.paginate page: params[:page], per_page: Settings.paginate.normal
  end

  def show
  end

  def new
    @position = Position.new
  end

  def edit
  end

  def create
    @position = Position.new position_params
    respond_to do |format|
      if @position.save
        format.html {redirect_to [:admin, @position], notice: t("position.create")}
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update position_params
        format.html {redirect_to [:admin, @position], notice: t("position.update")}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @position.destroy
    respond_to do |format|
      format.html {redirect_to admin_positions_url, notice: t("position.delete")}
      format.json {head :no_content}
    end
  end

  private
  def set_position
    @position = Position.find params[:id]
  end

  def position_params
    params.require(:position).permit :name, :description
  end
end
