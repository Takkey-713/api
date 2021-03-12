class ListsController < ApplicationController]
  before_action :select_list, only: [:destroy, :update]
  def index
    lists_all
  end

  def create
    List.create(list_params)
    lists_all
  end

  def update
    @list.update(name: params[:name])
    lists_all
  end

  def destroy
    @list.destroy  
    lists_all
  end

  private

  def list_params
    params.require(:list).permit(:name).merge(user_id: @current_user.id)
  end

  def select_list
    @list = List.find(params[:id])
  end

  def lists_all
    lists = List.where(user_id: @current_user&.id)
    render json: lists
  end
end
