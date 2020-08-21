class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:search] == nil && params[:name] == nil
      if params[:sort] == nil
        @tasks = Task.page(params[:page]).per(8).order('created_at DESC')
      else
        @tasks = Task.page(params[:page]).per(8).order(params[:sort])
      end
    elsif params[:search].blank? && params[:name].present?
      @tasks = Task.where('name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
    elsif params[:search].present? && params[:name].blank?
      @tasks = Task.where(status: params[:search]).page(params[:page]).per(8)
    else
      @tasks = Task.where(status: params[:search]).where('name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
    end
  end

  def new
    @task = Task.new
  end

  def create
    puts task_params[:name]
    @task = Task.new(processed_params)
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
    if @task.update(processed_params)
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
    params.require(:task).permit(:name, :content, :dead_line, :status, :priority)
  end

  def processed_params
      int_param = task_params
      int_param[:priority] = int_param[:priority].to_i
      int_param
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
