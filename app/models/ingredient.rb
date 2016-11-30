class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def self.search(search)
	where("name LIKE ?", "%#{search}%")
  end
end
