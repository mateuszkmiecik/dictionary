class LanguagesController < ApplicationController

  def index
  	@languages = Language.all
  end

  def new
    @language = Language.new
  end

  def create
    @language = Language.new(params[:language])

  	if @language.save
  		redirect_to root_path
  	else
  		render action: 'new'
  	end
  end

end
