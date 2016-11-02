class Recipe < ActiveRecord::Base
	belongs_to :user
	has_many :ingredients
	has_many :directions
	has_many :bookmarks, dependent: :destroy
	has_many :taggings
	has_many :tags, through: :taggings

  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true	
  accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true	
  
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
