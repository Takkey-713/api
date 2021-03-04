class BoardsController < ApplicationController
  before_action :select_board, only: [:destroy, :update]
  def index
    boards_all
  end

  def create
    Board.create(board_params)
    boards_all
  end

  def update
    @board.update(name: params[:name])
    boards_all
  end

  def destroy
    @board.destroy  
    boards_all
  end

  private

  def board_params
    params.require(:board).permit(:name).merge(user_id: @current_user.id)
  end

  def select_board
    @board = Board.find(params[:id])
  end

  def boards_all
    boards = Board.where(user_id: @current_user&.id)
    render json: boards
  end
end
