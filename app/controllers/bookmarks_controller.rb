class BookmarksController < ApplicationController

	def index
		@bookmarks = Bookmark.all.order('created_at DESC')
	end


	def new
		@bookmark = Bookmark.new
	end
 
   def create

     recipe = Recipe.find(params[:recipe_id])
     bookmark = current_user.bookmarks.build(recipe: recipe)
 
     if bookmark.save
       flash[:notice] = "Recipe bookmarked."
     else
       flash[:alert] = "Bookmarking failed."
     end
 
     redirect_to recipe

	end

   def destroy
     recipe = Recipe.find(params[:recipe_id])
     bookmark = current_user.bookmarks.find(params[:id])
 
     if bokmark.destroy
       flash[:notice] = "This recipe is no longer bookmarked."
     else
       flash[:alert] = "Un-bookmarking failed."
     end
       redirect_to recipe
   end

	private

end
