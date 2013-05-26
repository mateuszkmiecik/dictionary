require 'spec_helper'

describe "Words" do
  describe "GET /words" do
  	it "display some words" do
  		visit words_path
  		page.should have_content 'Dictionary'
  	end
  end
end
