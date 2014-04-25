class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
	validates :name, presence: true, uniqueness: true
	has_secure_password
	after_destroy :ensure_an_admin_remains

	def ensure_an_admin_remains
		if User.count.zero?
			raise "Can't delete last user"
		end
	end
end
