class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all.order("created_at DESC")
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
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

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
end
