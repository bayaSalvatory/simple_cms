class Section < ApplicationRecord
	belongs_to :page, optional: true
	has_many :section_edits
	has_many :editors, :through => :section_edits, :class_name => "AdminUser"

	acts_as_list :scope => :page

	after_save :touch_page

	CONTENT_TYPE =['text', 'HTML']

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_inclusion_of :content_type, :in => CONTENT_TYPE, :message => "Musr be of : #{CONTENT_TYPE.join(',')}"
	validates_presence_of :content

	scope :visible, -> { where(:visible => true) }
	scope :invisible, -> { where(:visible => false) }
	scope :sorted, -> {order("sections.position ASC") }
	scope :newest_first, -> {order("sections.created_at DESC")}
	scope :search, -> (query){
		where(["name LIKE ? ", "%#{query}%"])
	}

	private
	def touch_page
		# touch is similar as update attribute time.
		# page.update_attribute(:updated_at, Time.now)
		page.touch 
	end

end
