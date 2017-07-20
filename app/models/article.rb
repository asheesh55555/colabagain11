class Article < ApplicationRecord
	  acts_as_votable
	 belongs_to :user
	 has_many :endorses
end
