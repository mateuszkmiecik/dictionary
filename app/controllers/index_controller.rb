class IndexController < ApplicationController

	def index
		@languages = Language.all
		@dictionaries = Dictionary.order('dictionaries.position ASC')
	end

end