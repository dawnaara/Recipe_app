class RecipesController < ApplicationController
  require 'will_paginate/array'#must include this line since we are calling will_paginate on an array in the index on line 13.
  before_action :find_recipe, only: [:show, :edit, :update, :destroy, :modify]

  def index
    #@recipes = Recipe.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)#calling on will_paginate gem to organize recipes 6 per page
  
    if params[:search]
      general_recipes = Recipe.search(params[:search])
      direction_recipes = Direction.search(params[:search]).map(&:recipe)
      ingredient_recipes = Ingredient.search(params[:search]).map(&:recipe)

      @recipes = (general_recipes + direction_recipes + ingredient_recipes).uniq.sort {|a,b| b[:created_at] <=> a[:created_at] }.paginate(page: params[:page], per_page: 9)
    else
      @recipes = Recipe.all.order("created_at DESC").paginate(page: params[:page], per_page: 9)
    end
  end

  def show
    @tags = @recipe.tags
    @tag = Tag.new 

    @ratings =  @recipe.ratings.order("created_at DESC")
    unless @ratings.present?
     @avg_rating = 0
    else
     @avg_rating = @ratings.average(:stars).present? ? @ratings.average(:stars).round(2) : 0 #ternary condition when first statement is true then its run immediate statement after ? and if condition false its run statement after ':'
    end

    @modified_recipes = @recipe.modified_recipes 
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
    @modified_recipe = @recipe.dup #makes a duplicate of the instance of the recipe model
    @modified_recipe.video_embeded_url = nil #tells rails not to copy video
    @modified_recipe.image = nil #tells rails not to copy image
    # begin
    #   @modified_recipe.image.create(attachment: @recipe.attachment)
    # rescue
    #   Rails.logger.info ">>> could not duplicate image: #{@recipe.image.inspect}"
    # end
    @modified_recipe.directions = @recipe.directions #copies directions model
    @modified_recipe.ingredients = @recipe.ingredients #copies ingredients model
    @modified_recipe.user = current_user #to associate the modified_recipe with current_user

    if @modified_recipe.save
      flash[:notice] = "Modify the recipe!"
      redirect_to(edit_recipe_path(@modified_recipe))
    else
      flash[:notice] = "Something went wrong. Please try again."
      redirect_to @recipe
    end
  end

  def search
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
    else
      @recipes = Recipe.all.order('created_at DESC')
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :rating, :image, :video_embeded_url, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
end