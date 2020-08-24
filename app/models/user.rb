class User < ApplicationRecord
  before_destroy :ensure_admin_or_not
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :tasks

  private
  def ensure_admin_or_not
    if self.admin == true
      errors.add :base, "管理者は削除できません"
      throw(:abort)
    end
  end
end
