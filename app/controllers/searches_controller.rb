class SearchesController < ApplicationController
  def index
    binding.pry
    @tasks = Task.where('name LIKE(?)', "%#{params[:keyword]}%").where(user_id: @current_user.id).limit(20)
    render json: @tasks
  end
end
