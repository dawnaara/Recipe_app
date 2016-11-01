class TagsController < ApplicationController
  before_action :find_tags, only: [:show, :create]

  def index
  	@tags = Tag.all
  end

  def new
  	@tag = Tag.new
  end

  def create
  end

  def show
  end

  private

  def find_tags
  	@tag = Tag.find(params[:id])
  end

end
