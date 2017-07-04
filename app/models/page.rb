class Page < ApplicationRecord
	belongs_to :subject, optional: true
	has_many :sections
	has_and_belongs_to_many :editors, class_name: "AdminUser"

	acts_as_list :scope => :subject

	before_validation :add_default_permalink
	after_save :touch_subject
	after_destroy :delete_related_sections

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	
	# validates_length_of :permalink, :within 3..255
	# validates_uniqueness_of :permalink
	# for unique values by subject use ":scope => :subject_id"

	scope :visible, -> { where(:visible => true) }
	scope :invisible, -> { where(:visible => false) }
	scope :sorted, -> {order("pages.position ASC") }
	scope :newest_first, -> {order("pages.created_at DESC")}
	scope :search, -> (query){
		where(["name LIKE ? ", "%#{query}%"])
	}

    private 

	def add_default_permalink
		if permalink.blank?
			self.permalink = "#{id}-#{name.parameterize}"
		end
	end

	def touch_subject
		# touch is similar as update attribute time.
		# subject.update_attribute(:updated_at, Time.now)
		subject.touch 
	end

	def delete_related_sections
		self.sections.each do |section|
		# Or perhaps instead of destroy, you would
		# move them to a another page.
		# section.destroy
		end
	end
end
