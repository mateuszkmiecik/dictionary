class WordsController < ApplicationController

  def index
  	if params[:from] == params[:to]
  		redirect_to root_path
  	end
  end
  
end
