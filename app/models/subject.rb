class Subject < ApplicationRecord

	# could delete related pages automatically
	# whenever a subject is deleted:
	# has_many :pages, :dependent => :destroy
	has_many :pages

	acts_as_list

	validates_presence_of :name
	validates_length_of :name, :maximum => 255

	scope :visible, -> { where(:visible => true) }
	scope :invisible, -> { where(:visible => false) }
	scope :sorted, -> {order("subjects.position ASC") }
	scope :newest_first, -> {order("subjects.created_at DESC")}
	scope :search, -> (query){
		where(["name LIKE ? ", "%#{query}%"])
	}
end
