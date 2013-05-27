class Word < ActiveRecord::Base
  attr_accessible :lang_id, :text

  belongs_to :language
  has_many :translations
end
