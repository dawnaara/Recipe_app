class User < ActiveRecord::Base
	has_many :recipes
	has_many :ingredients
	has_many :directions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def name
  	"#{first_name} #{last_name}"
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

end
