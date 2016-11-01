module TagsHelper
	def tags_to_buttons(tags)
		raw tags.map { |l| link_to l.name, tag_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
	end
end
