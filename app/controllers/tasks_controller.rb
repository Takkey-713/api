class TasksController < ApplicationController
  before_action :select_task, only: [:update, :destroy, :update_status]

  def index
    tasks_all
  end

  def create
    @task = Task.create(task_params)
    tasks_all
  end

  def update
    @task.update(task_params)
    tasks_all
  end

  def destroy
    @task.destroy
    tasks_all
  end

  def update_status
    @task.update(status: params[:status])
    tasks_all
  end

  private

  def task_params
    params.require(:task).permit(:name, :explanation, :deadline_dateapra, :board_id).merge(user_id: @current_user.id)
  end

  def select_task
    @task = Task.find(params[:id])
  end

  def tasks_all
    @tasks = Task.where(user_id: @current_user.id)
    render :all_tasks
  end
end
