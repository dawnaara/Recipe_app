class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :modify]
  #before_action :find_rating, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order("created_at DESC")
  end

  def show
    @tags = @recipe.tags
    @tag = Tag.new  
    @ratings = Rating.where(recipe_id: @recipe.id).order('created_at DESC')#ratings where the recipe id is the recipe id. ratings is in the show page loop so we must have ratings defined here.
    if @ratings.blank?
      @avg_rating = 0
    else
      @avg_rating = @ratings.average(:stars).round(2)
    end
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      @recipe.tags = Tag.update_tags(params[:recipe][:tags])
      flash[:notice] = "Your recipe was saved!"
      redirect_to @recipe 
    else
      flash[:alert] = "Whoops, something went wrong. Try again."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      @recipe.tags = Tag.update_tags(params[:recipe][:tags])      
      redirect_to @recipe
    else
      flash[:notice] = "There was an error updating your recipe."
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      flash[:notice] = "Your recipe was deleted."
      redirect_to current_user
    else
      flash[:alert] = "Your recipe was not deleted. Please try again."
      redirect_to @recipe 
    end
  end

  def modify
    # look up recipe sent via params[:id]
    # for current_user, do a current_user.recipes.create using the values in the recipe
    # maybe look up clone or duplicate object in rails
    @modified_recipe = @recipe.dup 

    if @modified_recipe.save
      flash[:notice] = "Here's your new recipe!"
      redirect_to @modified_recipe
    else
      flash[:notice] = "Something went wrong. Please try again."
      redirect_to modify_recipe_path
    end

    # redirect to current_user's receipe edit page for that new recipe
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :rating, :image, :video_embeded_url, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end

  #def find_rating
   # @rating = Rating.find(params[:recipe_id])
  #end
end