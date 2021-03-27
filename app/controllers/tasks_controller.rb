class TasksController < ApplicationController
  before_action :select_task, only: [:update, :destroy, :update_status]

  def index
    tasks_all
  end

  def create
    @task = Task.new(task_params)
    check_validate
  end

  def update
    validate_update
  end

  def destroy
    @task.destroy
    tasks_all
  end

  private

  def task_params
    params.require(:task).permit(:name, :explanation, :deadline_date, :board_id, :list_id).merge(user_id: @current_user&.id)
  end

  def select_task
    @task = Task.find(params[:id])
  end

  def tasks_all
    @tasks = Task.where(user_id: @current_user&.id)
    render json: @tasks
  end

  def check_validate
    if @task.save
      tasks_all
    else
      tasks_all
    end
  end

  def validate_update
    if @task.update(task_params)
      tasks_all
    else
      tasks_all
    end
  end
end
