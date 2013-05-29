class IndexController < ApplicationController

	def index
		@languages = Language.all
	end

end