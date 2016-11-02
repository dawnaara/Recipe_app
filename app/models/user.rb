class User < ActiveRecord::Base
  has_many :recipes
  has_many :bookmarks, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def bookmark_for(recipe)
    bookmarks.where(recipe_id: recipe.id).first
  end

  def bookmarked_recipes
    bookmarks.map(&:recipe)
  end


end
