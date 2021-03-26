class ListsController < ApplicationController
  before_action :select_list, only: [:destroy, :update]
  def index
    lists_all
  end

  def create
    @list = List.new(list_params)
    if @list.save 
      lists_all
    elsif @list.errors.full_messages.include?("User must exist")
      render json: {errors: "ログインしてください。"}
    elsif @list.errors.full_messages.include?("Name can't be blank")
      render json: {errors: "リストの名前を入力してください。"}
    else 
      render json: {errors: "ボードを作成してください。"}
    end
  end

  def update
    if @list.update(list_params)
      lists_all
    elsif @list.errors.full_messages.include?("User must exist")
      render json: {errors: "ログインしてください。"}
    elsif @list.errors.full_messages.include?("Name can't be blank")
      render json: {errors: "リストの名前を入力してください。"}
    else 
      render json: {errors: "ボードを作成してください。"}
    end
  end

  def destroy
    @list.destroy  
    lists_all
  end

  private

  def list_params
    params.require(:list).permit(:name,:board_id).merge(user_id: @current_user&.id)
  end

  def select_list
    @list = List.find(params[:id])
  end

  def lists_all

    lists = List.where(user_id: @current_user&.id)
    render json: lists
  end
end
