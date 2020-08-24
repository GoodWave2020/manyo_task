module ApplicationHelper
  def choose_new_or_edit
    if action_name == 'edit'
      admin_user_path
    else
      admin_users_path
    end
  end
  def admin?(user)
    if user.admin
      t('activerecord.attributes.user.admin')
    end
  end
end
