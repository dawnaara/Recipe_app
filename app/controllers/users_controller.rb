class UsersController < ApplicationController
	require 'will_paginate/array'

  def show
  	@user = User.find(params[:id])
  	@recipes = Recipe.find(params[:id])
  	@user_recipes = @user.recipes.order("created_at DESC").paginate(page: params[:page], per_page: 9)#here we are using will_paginate to sort through all the recipes this particular user created.
  end
end

