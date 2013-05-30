class DictionariesController < ApplicationController

	before_filter :get_deletion, :only => [:destroy]

	def index
		@languages = Language.all
		@dictionaries = Dictionary.order('dictionaries.position ASC')
	end

	def new
		@dictionary = Dictionary.new
		@languages = Language.all
	end

	def create
		@languages = Language.all
		@dictionary = Dictionary.new(params[:dictionary])
		@dictionary.position = Dictionary.all.count + 1

		if @dictionary.save
			@dictionary2 = Dictionary.new :from => @dictionary.to, :to => @dictionary.from, :position => Dictionary.all.count + 1

			if @dictionary2.save
				redirect_to dictionaries_path, :notice => 'Dictionaries have been created.'
			else
				render :action => 'new'
			end
		else
			render :action => 'new'
		end
	end

	def delete
		@dictionary = Dictionary.find(params[:id])
		@from = Language.find(@dictionary.from).name
		@to = Language.find(@dictionary.to).name		
	end

	def get_deletion
		@deletion = Dictionary.find(params[:id])
		@second = Dictionary.where(:from => @deletion.to, :to => @deletion.from).limit(1)		
	end


	def destroy
		Dictionary.destroy params[:id]		
		Dictionary.destroy @second[0].id

		redirect_to dictionaries_path, :notice => 'Dictionaries have been deleted.'
		
	end

	def sort
		@dictos = Dictionary.all

		@dictos.each do |d|
			d.position = params['dictionary'].index(d.id.to_s) + 1
			d.save
		end
		render :nothing => true
	end
	
end