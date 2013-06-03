class WordsController < ApplicationController

  before_filter :parse_fromto

  before_filter :check_languages

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

  def edit
    @word = Word.find params[:id]
  end

  def update
    @word = Word.find params[:id]

    if @word.update_attributes params[:word]
      redirect_to word_path(:id => @word.id), :notice => 'Word has been updated.'
    else
      render :action => 'edit'
    end    
  end

  def destroy

    w = Word.find params[:id]
    t = Translation.where(:word_id => w.id, :lang_id => @to.id)

    t.each do |tr|
      tr.destroy
    end

    Word.destroy params[:id]

    redirect_to words_path, :notice => 'Word and its translation have been deleted.'
    
  end


  def search

    if params[:search].empty?
      redirect_to words_path
    end
    

    @words = Word.where("text LIKE ? and lang_id = ?", "%#{params[:search]}%", @from.id)
    @translations = Translation.where("text LIKE ? and lang_id = ?", "%#{params[:search]}%", @to.id)
    
  end


  private

  def check_languages
    if params[:from] == params[:to]
      redirect_to root_path
    end    
  end

  def parse_fromto
    @from = Language.where(:short => params[:from]).limit(1)[0]
    @to = Language.where(:short => params[:to]).limit(1)[0]
  end
  
end
