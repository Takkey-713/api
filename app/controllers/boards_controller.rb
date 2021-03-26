class BoardsController < ApplicationController
  before_action :select_board, only: [:destroy, :update]
  def index
    boards_all
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      boards_all
    elsif @board.errors.full_messages.include?("Name can't be blank")
      boards = Board.where(user_id: @current_user&.id)
      render json: boards, errors: "ボードの名前を入力してください。"
    else
      boards = Board.where(user_id: @current_user&.id)
      render json: boards, errors: "ログインしてください。"
    end
  end

  def update
    if @board.update(board_params)
      boards_all
    elsif @board.errors.full_messages.include?("Name can't be blank")
      boards = Board.where(user_id: @current_user&.id)
      render json: boards, errors: "ボードの名前を入力してください。"
    else
      boards = Board.where(user_id: @current_user&.id)
      render json: boards, errors: "ログインしてください。"
    end
  end

  def destroy
    @board.destroy  
    boards_all
  end


  def select
    @board = select_board
    render json: @board
  end


  private

  def board_params
    params.require(:board).permit(:name).merge(user_id: @current_user&.id)
  end

  def select_board
    @board = Board.find(params[:id])
  end

  def boards_all
    boards = Board.where(user_id: @current_user&.id)
    render json: boards
  end
end
