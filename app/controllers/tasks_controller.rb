class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :authenticate_user
  before_action :check_user_for_task, only: [:edit, :update, :destroy]
  def index
    if params[:search] == nil && params[:name] == nil && params[:label_id] == nil
      if params[:sort] == nil
        @tasks = current_user.tasks.page(params[:page]).per(8).order('created_at DESC')
      else
        @tasks = current_user.tasks.page(params[:page]).per(8).order(params[:sort])
      end
    elsif params[:label_id].present? && params[:name].blank? && params[:search].blank?
      @tasks = current_user.tasks.joins(:labels).where(labels: { id: params[:label_id] }).page(params[:page]).per(8)
    elsif params[:name].present? && params[:search].blank?
      if params[:label_id].blank?
        @tasks = current_user.tasks.where('tasks.name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
      else
        @tasks = current_user.tasks.joins(:labels).where(labels: { id: params[:label_id] }).where('tasks.name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
      end
    elsif params[:search].present? && params[:name].blank?
      if params[:label_id].blank?
        @tasks = current_user.tasks.where(status: params[:search]).page(params[:page]).per(8)
      else
        @tasks = current_user.tasks.joins(:labels).where(labels: { id: params[:label_id] }).where(status: params[:search]).page(params[:page]).per(8)
      end
    else
      if params[:label_id].blank?
        @tasks = current_user.tasks.where(status: params[:search]).where('tasks.name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
      else
        @tasks = current_user.tasks.joins(:labels).where(labels: { id: params[:label_id] }).where(status: params[:search]).where('tasks.name like ?', "%#{params[:name]}%").page(params[:page]).per(8)
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(processed_params)
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
    params.require(:task).permit(:name, :content, :dead_line, :status, :priority, { label_ids: [] })
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
