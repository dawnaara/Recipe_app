class TagsController < ApplicationController
  before_action :find_tags, only: [:show, :create]

  def index
  	@tags = Tag.all#.order("created_at DESC").paginate(page: params[:page], per_page: 6) - only on index if we were showing all tags on one page with all their recipes. we are not doing that in this app.
  end

  def new
  	@tag = Tag.new
  end

  def create
  end

  def show
    @recipes = @tag.recipes.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
  end

  private

  def find_tags
  	@tag = Tag.find(params[:id])
  end

end
