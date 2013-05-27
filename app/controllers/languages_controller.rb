class LanguagesController < ApplicationController

  def index
  	@languages = Language.all
  end

  def new

  end

  def create

  	Language.create params[:language]
  	redirect_to root_path

  end

end
