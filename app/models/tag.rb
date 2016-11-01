class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :recipes, through: :taggings

	def self.update_tags(tag_string)
		return Tag.none if tag_string.blank?
		tag_string.split(",").map do |tag|
			Tag.find_or_create_by(name: tag.strip)
		end
	end

end
