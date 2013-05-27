class Translation < ActiveRecord::Base
  attr_accessible :desc, :lang_id, :text, :word_id
  belongs_to :word
end
