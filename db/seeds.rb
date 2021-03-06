# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
titles = [
  "massTitle_1",
  "Debug : logger.info",
  "CodeRay demonstration"
]
contents = [
  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
  "
  ${CODE_ruby}
  logger.info(\"session info\" + session.inspect)
  ${!CODE_ruby}
  schreibt einen string in den log
  ",
  "
  
  CodeRay test : 
  ${CODE_ruby}
    def read
    @title = \" | Lesen\"
    @entries = []
    
    if params[:id] then
      @entry = Entry.find params[:id]
    else
      c = Entry.count
      if c < 5 then
        c.downto(1) do |i|
          @entries.push Entry.find i
        end        
      else
        5.downto(1) do |i|
          @entries.push Entry.find i
        end
      end
    end
  end
  ${!CODE_ruby}
  
  und siehe da, es ist BUNT ^^
  
  "
]


e = Entry.create(:content => 'Hier steht wichtiger Inhalt', :title => "erster content")
e.author_id = 1
e.save

titles.count.times do |i|
  e = Entry.create(:content => contents[i], :title => titles[i])
  e.author_id = 1
  e.save
end

a_attr = {
  :password => "2f7e4ba61e355c7146eef2f16ef7c5019cd57dea2540ed5086e2d3cfc54a0529",
  :salt => "284db8a30f31b9f8d2672d5a3d5f4241de88d99edd5ca32e7ae73cfc529bbd5a",
  :name => "Moi"
}
Author.create(a_attr).save

#a_attr={
#  :password => "1ac0e11c946e5c291062eed4ec9209a3eac69d283eadc45368fff8d58b1de9d7",
#  :salt => "7c26d37993f1427a5b0483e94a1fefa8dd1aad8c583a75df4ffdf719190ce577",
#  :name => "Zeroalpha"  
#}
#Author.create(a_attr).save

