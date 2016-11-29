class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :ingredients
	has_many :directions
	has_many :ratings, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :taggings
	has_many :tags, through: :taggings
	has_many :modified_recipes, class_name: "Recipe", foreign_key: :modified_from_id 
	#modified_recipes doesn't have it's own model so we create an association and foreign key.
	belongs_to :modified_recipe, class_name: "Recipe", foreign_key: :modified_from_id 
	#has_many and belongs_to recipe both go on this model.

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true	
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true	
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" },         default_url: "/images/:style/missing.png"

      validates_attachment :image,
                        content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                        size: { in: 0..5.megabytes }

	def self.search(search)
  		where("title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
	end

end
