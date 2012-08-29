class Services::Album < ActiveRecord::Base
  attr_accessible :artist, :title

  validates :artist, :title, :presence => true
end
