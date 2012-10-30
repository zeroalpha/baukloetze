class Codes < ActiveRecord::Base
  attr_accessible :author, :code, :created_at, :description, :title, :type
end
