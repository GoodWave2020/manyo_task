module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
   current_user.present?
  end
  def authenticate_user
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end
  def check_user_for_user
    if @current_user != @user
      flash[:notice] = t("notice.you_can't_edit_other_user's_profile")
      redirect_to pictures_path
    end
  end
  def check_user_for_task
    if @current_user != @task.user
      flash[:notice] = t("notice.you_can't_destroy_or_edit_other_user's_tasks")
      redirect_to tasks_path
    end
  end
  def administrate_user
    if @current_user != User.find_by(admin: true)
      flash[:notice] = t('notice.you_are_not_administrator')
      redirect_to tasks_path
    end
  end
end
