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
  		redirect_to languages_path, :notice => 'Language has been created.'
  	else
  		render action: 'new'
  	end
  end

  def destroy

    Language.destroy params[:id]
    redirect_to :back, :notice => 'Language has been deleted.'
    
  end

end
