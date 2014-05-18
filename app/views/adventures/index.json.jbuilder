json.adventures @adventures do |adventure|
	json.title adventure.title
	json.author adventure.author
	json.guid adventure.guid
	json.created_at adventure.created_at
	json.updated_at adventure.updated_at

	json.pages adventure.pages do |page|
		json.name page.name
		json.text page.text
	end

end
