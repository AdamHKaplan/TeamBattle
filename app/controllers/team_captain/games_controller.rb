# games_controller.rb
class TeamCaptain::GamesController < ApplicationController
  before_action :set_team
  before_action :set_game, only:[:show, :update, :join_game]
  before_action :team_captain_required!
  def index
    @games = Game.all
  end
  
  def show
  end
  
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      @game.teams.push(@team)
      @game.users.push(@team.users)
      flash[:notice] = "Game was successfully created"
    else
      flash[:alert] = "Game was not created"
    end
    redirect_to root_path
  end

  def join_game
    if @team.game_id.nil?
      # add team to game
      @game.teams.push(@team)
      # add user to game
      @game.users += @team.users
      # start the game
      @game.update(:started? => true)
      session[:game_id] = @game.id
      # prevent game's teams from being joined because started playing
      
      # game's users are now able to access the dashboard



      # do any preliminary e-mailing

      flash[:notice] = "Successfully joined #{@game.name}. Game has started good luck!"
    else
      flash[:error] = "You are already in a game"
    end
    redirect_to team_captain_game_path(@game)
  end

  private
  def set_game
    @game = Game.find(params[:id])
  end
  
  def set_team
    @team = Team.find(current_user.team_id)
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
