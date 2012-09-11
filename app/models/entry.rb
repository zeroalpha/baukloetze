class Entry < ActiveRecord::Base
  attr_accessible :content, :title,:author_id
  
  validates_presence_of :content,:title#,:autor_id
  validates_uniqueness_of :title
  belongs_to :author
end
