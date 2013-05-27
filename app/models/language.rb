class Language < ActiveRecord::Base
  attr_accessible :name, :short
  validates_presence_of :name, :short
  validates_uniqueness_of :short
end
