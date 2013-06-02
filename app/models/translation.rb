class Translation < ActiveRecord::Base
  attr_accessible :desc, :lang_id, :text, :word_id
  belongs_to :word

  validates :text, :presence => { :message => "Translation can't be blank." }
  validates :text, :uniqueness => { :scope => [ :word_id, :lang_id ], :message => 'Translation already exists.' }
end
