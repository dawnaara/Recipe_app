class Direction < ActiveRecord::Base
  belongs_to :recipe

  def self.search(search)
	where("step ILIKE ?", "%#{search}%")
  end
end
