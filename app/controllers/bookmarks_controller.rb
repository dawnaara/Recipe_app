class BookmarksController < ApplicationController

	def index
		@bookmarked_recipes = Bookmark.all.order('created_at DESC').map(&:recipe)#.paginate(page: params[:page], per_page: 6)page)
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
 
     if bookmark.destroy
       flash[:notice] = "This recipe is no longer bookmarked."
     else
       flash[:alert] = "Un-bookmarking failed."
     end
       redirect_to recipe
   end
end
