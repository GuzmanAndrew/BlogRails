class Article < ApplicationRecord
    include AASM

    belongs_to :user
    has_many :comments
    after_create :save_categories

    has_many :has_categories
	has_many :categories, through: :has_categories
    
    validates :title, presence: true, uniqueness: true
    validates :body, presence: true, length: { minimum: 20 }

    has_attached_file :cover, :styles => { :medium => ["1280x720"], :thumb => ["800x600"] }
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

    #Custom setter
	def categories=(value)
		@categories = value		
    end

    aasm column: "state" do 
		state :in_draft, initial: true
		state :published

		event :publish do
			transitions from: :in_draft, to: :published
		end

		event :unpublish do
			transitions from: :published, to: :in_draft
		end
	end

    private

    def save_categories
        unless @categories.nil?
			@categories.each do |category_id|
				HasCategory.create(category_id: category_id, article_id: self.id)
			end
		end 
    end
    
end