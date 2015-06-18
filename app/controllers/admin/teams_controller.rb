class Admin::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all.paginate page: params[:page], per_page: Settings.paginate.normal
  end

  def show
    @team = Team.find params[:id]
    @users = @team.users
    @projects = @team.projects
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new team_params

    respond_to do |format|
      if @team.save
        format.html {redirect_to [:admin, @team], notice: t("team.create")}
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update team_params
        format.html {redirect_to [:admin, @team], notice: t("team.update")}
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html {redirect_to admin_teams_url, notice: t("team.delete")}
      format.json {head :no_content}
    end
  end

  private
  def set_team
    @team = Team.find params[:id]
  end

  def team_params
    params.require(:team).permit :name, :description, :leader, user_ids: []
  end
end
