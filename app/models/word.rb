class Word < ActiveRecord::Base
  attr_accessible :lang_id, :text

  belongs_to :language
  has_many :translations

  validates :text, :presence => { :message => "Word can't be blank." }
  validates :text, :uniqueness => { :scope => :lang_id, :message => "Word already exists." }
end
