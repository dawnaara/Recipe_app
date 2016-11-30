class Direction < ActiveRecord::Base
  belongs_to :recipe

  def self.search(search)
	where("step LIKE ?", "%#{search}%")
  end
end
