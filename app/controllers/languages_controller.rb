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

  def edit
    @language = Language.find(params[:id])    
  end

  def update

    @language = Language.find(params[:id])

    if @language.update_attributes params[:language]
      redirect_to languages_path, :notice => 'Language has been updated.'
    else
      render :action => 'edit'
    end
    
  end

  def destroy
    @dictionaries = Dictionary.where('"from" = ? OR "to" = ?', params[:id], params[:id])
    if !@dictionaries.empty?
      render :action => 'info'
    else
      Language.destroy params[:id]

      t = Translation.where(:lang_id => params[:id])
      t.each { |x| x.destroy }

      w = Word.where(:lang_id => params[:id])
      w.each { |x|
        x.translations.each do |a|
          a.destroy
        end
      }

      w.each {|x| x.destroy}

      redirect_to :back, :notice => 'Language has been deleted.'  
    end      
  end

end
