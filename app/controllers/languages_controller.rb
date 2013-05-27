class LanguagesController < ApplicationController

  def index
  	@languages = Language.all
  end

  def new

  end

  def create
  	if Language.create params[:language]
  		redirect_to root_path
  	else
  		render action: 'new'
  	end
  end

end
