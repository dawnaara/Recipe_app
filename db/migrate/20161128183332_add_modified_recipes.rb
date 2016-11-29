class AddModifiedRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :modified_from_id, :integer
  	add_index :recipes, :modified_from_id
  end
end
