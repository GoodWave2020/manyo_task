class User < ApplicationRecord
  before_destroy :ensure_admin_count
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many :tasks, dependent: :destroy

  private
  def ensure_admin_count
    if User.all.where(admin: true).count == 1 
      errors.add :base, '管理者が1人もいない状態にはできません'
      throw(:abort)
    end
  end
end
