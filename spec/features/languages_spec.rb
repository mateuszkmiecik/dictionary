require 'spec_helper'

describe "Languages" do
  describe "GET /languages" do
    it "should display message about no languages" do

      visit root_path
      page.should have_content "There are no languages yet."

    end

    it "should display message about one language left to go" do 
      
      @language = Language.create :short => 'pl', :name => 'polish'

      visit root_path
      page.should have_content "You have to specify one more language to create dictionary."

    end

    it "should show a list of dictionaries" do

      @language = Language.create :short => 'pl', :name => 'polish'
      @language2 = Language.create :short => 'de', :name => 'german'

      visit root_path
      page.should_not have_content "You have to specify one more language to create your dictionary."

    end
  end
  describe "GET /languages/new" do

    it "creates a new language" do

    	visit new_language_path
    	fill_in "language_short", :with => 'pl'
    	fill_in "language_name", :with => 'polish'

    	click_button "Add language"

    	current_path.should == languages_path
      	page.should have_content "polish"

    end

    it "prohibits language from being saved, if specified short code exists" do
      @language = Language.create :short => 'pl', :name => 'polish'

      visit new_language_path
      fill_in "language_short", :with => 'pl'
      fill_in "language_name", :with => 'polish'

      click_button "Add language"

      current_path.should == languages_path
      page.should have_content "Short has already been taken"
    end


    it "prohibits language from being saved, if name is empty" do

      visit new_language_path
      fill_in "language_short", :with => 'de'
      fill_in "language_name", :with => ''

      click_button "Add language"

      current_path.should == languages_path
      page.should have_content "Name can't be blank"
    end
  end

  describe "DELETE /languages" do

    it "should delete a language" do

      @language = Language.create :short => 'pl', :name => 'polish'

      visit languages_path
      click_link "delete_#{@language.id}"

      page.should have_content "Language has been deleted"
      page.should_not have_content "polish"

    end

  end



  describe "PUT /languages" do

    it "should update a language" do

      @language = Language.create :short => 'pl', :name => 'polish'

      visit languages_path
      click_link "edit_#{@language.id}"

      current_path.should == edit_language_path(@language)

      find_field('language_name').value == "polish"

      fill_in "language_short", :with => 'en'
      fill_in "language_name", :with => 'english'

      click_button "Update language"

      current_path.should == languages_path

      page.should have_content "Language has been updated"
      page.should have_content "english"

    end

    it "should not update language with an empty name" do

      @language = Language.create :short => 'pl', :name => 'polish'

      visit languages_path
      click_link "edit_#{@language.id}"
      
    end

  end

  
end
