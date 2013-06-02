class WordsController < ApplicationController

  before_filter :parse_fromto

  before_filter :check_languages

  def check_languages
    if params[:from] == params[:to]
      redirect_to root_path
    end    
  end

  def parse_fromto
    @from = Language.where(:short => params[:from]).limit(1)[0]
    @to = Language.where(:short => params[:to]).limit(1)[0]
  end

  def index

    @words = Word.where(:lang_id => @from.id).order("words.text ASC")

  end


  def new
  	@word = Word.new  	
  end

  def create
    @word = Word.create params[:word]

    if @word.save
      w = Word.last
      redirect_to word_path(:id => w.id), :notice => 'Word has been added.'
    else
      render :action => 'new'
    end    
  end

  def show

    @word = Word.find params[:id]

    @translation = Translation.new
    
  end
  
end
