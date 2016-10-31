class TagsController < ApplicationController
  
  def new
  	@tag = Tag.new
  end

  def create
  end

  def show
  	@tag = Tag.find(params[:id])
  end

end
