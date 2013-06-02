class TranslationsController < ApplicationController

	before_filter :parse_fromto

	def parse_fromto
	  @from = Language.where(:short => params[:from]).limit(1)[0]
	  @to = Language.where(:short => params[:to]).limit(1)[0]
	end

	def create
		@word = Word.find params[:word_id]
		@translation = Translation.create params[:translation]

		if @translation.save

			if !Word.where(:lang_id => @to.id, :text => @translation.text).exists? 
				w = Word.create :lang_id => @to.id, :text => @translation.text
				w.save
			else
				w = Word.where(:lang_id => @to.id, :text => @translation.text).limit(1)[0]
			end
		
			if !Translation.where(:lang_id => @from.id, :word_id => w.id, :text => @word.text).exists?
				t = Translation.create :lang_id => @from.id, :word_id => w.id, :text => @word.text, :desc => @translation.desc
				t.save
			end

			# redirect
			redirect_to word_path(:id => params[:word_id]), :notice => 'Translation has been added.'
		else
			render 'words/show'
		end
		
	end

end