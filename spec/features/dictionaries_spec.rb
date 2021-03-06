# encoding: UTF-8

require 'spec_helper'

describe "Dictionaries" do
  describe "GET /dictionaries" do
    it "should display message about not enough languages to go" do 

      visit dictionaries_path
      page.should have_content "There are no languages yet."
      
      @language = Language.create :short => 'pl', :name => 'polish'

      visit dictionaries_path
      page.should have_content "You have to specify one more language to create dictionary."

    end

  end

  describe "GET /dictionaries/new" do

    before :each do
      @language = Language.create :short => 'pl', :name => 'polish'
      @language2 = Language.create :short => 'de', :name => 'german'
    end


	  it "should create new dictionaries" do
  		visit dictionaries_path
  		page.should have_content "Dictionaries"

  		visit new_dictionary_path
  		page.should have_content "Add dictionary"
      select "german", :from => 'dictionary_from'
      select "polish", :from => 'dictionary_to'

      click_button "Add dictionary"
      current_path.should == dictionaries_path
      page.should have_content 'Dictionaries have been created.'

      page.should have_content "polish → german"
      page.should have_content "german → polish"

  	end

    it "should prevent from saving dictionaries if languages are the same" do

      visit new_dictionary_path
      select "german", :from => 'dictionary_from'
      select "german", :from => 'dictionary_to'

      click_button "Add dictionary"
      current_path.should == dictionaries_path

      page.should have_content 'Languages cannot be the same.'
    end

    it "should prevent from saving doctionaries if specified dictionary exists" do

      visit new_dictionary_path

      select "german", :from => 'dictionary_from'
      select "polish", :from => 'dictionary_to'

      click_button "Add dictionary"

      visit new_dictionary_path
      select "polish", :from => 'dictionary_from'
      select "german", :from => 'dictionary_to'

      click_button "Add dictionary"

      page.should have_content "Specified dictionary exists."

    end

  end

  describe "DELETE /dictionaries" do

    it "should delete a dictionary" do

      @language = Language.create :short => 'pl', :name => 'polish'
      @language2 = Language.create :short => 'de', :name => 'german'

      visit new_dictionary_path

      select "german", :from => 'dictionary_from'
      select "polish", :from => 'dictionary_to'

      click_button "Add dictionary"

      visit dictionaries_path
      click_link "delete_2"

      page.should have_content "Are you sure?"
      click_link "confirm_deletion"

      current_path.should == dictionaries_path

      page.should_not have_content 'german → polish'
      page.should_not have_content 'polish → german'

      page.should have_content "Dictionaries have been deleted."

    end

  end
end