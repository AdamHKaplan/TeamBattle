# player/games_controller.rb
class Player::GamesController < ApplicationController
  before_action :login_required!
  before_action :game_started!
  # this action returns an object containing all of the legal targets given move choice
  def target_team_users
    move_type = params[:move_choice]
    if move_type == "Attack"
      targets = current_game.users.alive - current_team.users.alive
    elsif move_type == "Heal"
      targets = current_team.users.alive
    else
      targets = []
    end
    render json: targets
      
  end
end