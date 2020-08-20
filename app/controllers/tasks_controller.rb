class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort] == nil
      @tasks = Task.all.order('created_at DESC')
    else
      @tasks = Task.all.order(params[:sort])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice:t('notice.new')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:t('notice.edit')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:t('notice.delete')
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :dead_line)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
