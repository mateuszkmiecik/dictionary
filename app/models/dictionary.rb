class Dictionary < ActiveRecord::Base
  attr_accessible :from, :position, :to

  validates_presence_of :from, :to
  validates :from, :uniqueness => { :scope => :to, :message => 'Specified dictionary exists.' }

  validate :validate_languages


  private

  def validate_languages
  	if from == to
  		errors.add(:base, 'Languages cannot be the same.')
  	end  	
  end
end
