# encoding: UTF-8

require 'spec_helper'

describe 'GET /words' do

	before :each do
		@pl = Language.create :short => 'pl', :name => 'polish'
		@en = Language.create :short => 'en', :name => 'english'
		@es = Language.create :short => 'es', :name => 'spanish'
	end

	it "should display chosen dictionary" do
		visit '/en/pl'

		page.should have_content 'english → polish'
	end

	it "should add new words" do
		visit '/en/pl'
		click_link "Add new word"
		
		page.should have_content "Add new word"

		fill_in "word_text", :with => "cow"
		click_button "Add word"

		page.should have_content "Word has been added."


	end

	it "should not add word with no text" do

		visit '/en/pl'
		click_link "Add new word"

		click_button "Add word"
		page.should have_content "Word can't be blank"

	end

	it "should display no translations" do

		@word = Word.create :lang_id => @pl.id, :text => 'krowa'
		visit '/pl/en'

		# check display
		page.should have_content "krowa"

		click_link "krowa"
		current_path.should == word_path(:from => @pl.short, :to => @en.short, :id => @word.id)

		page.should have_content "No translations yet."
	end

	it "should display message if translation text is empty" do
		@word = Word.create :lang_id => @pl.id, :text => 'krowa'
		visit word_path(:from => @pl.short, :to => @en.short, :id => @word.id)

		click_button "Add translation"
		page.should have_content "Translation can't be blank"
	end

	it "should add new translations also as new words if it is necessary" do
		@word = Word.create :lang_id => @pl.id, :text => 'krowa'
		visit word_path(:from => @pl.short, :to => @en.short, :id => @word.id)

		fill_in "translation_text", :with => 'cow'
		click_button "Add translation"

		Word.where(:text => 'cow').should exist
		Translation.where(:text => 'krowa').should exist
	end

	it "shouldn't add new Word if specified translation exists as word" do
		@word = Word.create :lang_id => @pl.id, :text => 'krowa'
		@word2 = Word.create :lang_id => @en.id, :text => 'cow'
		visit word_path(:from => @pl.short, :to => @en.short, :id => @word.id)

		fill_in "translation_text", :with => 'cow'
		click_button "Add translation"

		Word.where(:text => 'cow').length.should be_equal(1)
	end
	
end