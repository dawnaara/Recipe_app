class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@recipes = @user.recipes.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)#here we are using will_paginate to sort through all the recipes this particular user created.
  	@recipe = Recipe.new
  end
end

