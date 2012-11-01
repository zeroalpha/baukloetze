class Entry < ActiveRecord::Base
  attr_accessible :content, :title,:author_id
  
  validates_presence_of :content,:title#,:autor_id
  validates_uniqueness_of :title
#  belongs_to :author

  def preview
    #/<p>(.*)<\/p>/ =~ self.content
    copy = self.content.dup
    words = copy.count(" ") * (10.0/100)
    puts words
    words = words.to_i
    puts words
    preview = ""
    words.times do
      preview += copy.slice!(0,copy.index(" ")+1)
      puts preview
    end
    preview
  end

end
