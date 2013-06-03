require 'spec_helper'

describe "Removing language" do

	it "should remove all translations and words in this language" do

		@pl = Language.create :short => 'pl', :name => 'polish'
		@en = Language.create :short => 'en', :name => 'english'

		visit new_dictionary_path
  		select "english", :from => 'dictionary_from'
  		select "polish", :from => 'dictionary_to'
  		click_button "Add dictionary"

  		visit '/en/pl'

  		# words
		click_link "Add new word"
		fill_in "word_text", :with => "cow"
		click_button "Add word"

		fill_in "translation_text", :with => "krowa"
		click_button "Add translation"


		click_link "Add new word"
		fill_in "word_text", :with => "house"
		click_button "Add word"

		fill_in "translation_text", :with => "dom"
		click_button "Add translation"


		click_link "Add new word"
		fill_in "word_text", :with => "tree"
		click_button "Add word"

		fill_in "translation_text", :with => "drzewo"
		click_button "Add translation"

		Translation.all.length.should be_equal(6)

		# deletion

		visit dictionaries_path
		click_link 'delete_1'
		click_link "confirm_deletion"

		Dictionary.all.length.should be_equal(0)

		# delete first language
		visit languages_path
		id = @en.id
		click_link "delete_2"

		pp Word.all
		pp Translation.all

		Translation.all.length.should be_equal(0)
		Word.all.length.should be_equal(3)

		Word.where(:lang_id => id).length.should be_equal(0)

		# delete second language
		click_link "delete_1"

		Word.all.length.should be_equal(0)
		Language.all.length.should be_equal(0)

	end
	
end