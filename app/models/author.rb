class Author < ActiveRecord::Base
  attr_accessible :entry_id, :name, :password,:salt
  
  validates_presence_of :name
  validates_uniqueness_of :name
#  has_many :entries
  
  before_save :downcase_name
  
  private
  def downcase_name
    self.name.downcase! unless self.name.blank?
  end
  
end
