class AddVideoEmbededUrlToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :video_embeded_url, :text
  end
end
