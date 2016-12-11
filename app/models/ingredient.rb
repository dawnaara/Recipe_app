class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def self.search(search)
	where("name ILIKE ?", "%#{search}%")
  end
end
