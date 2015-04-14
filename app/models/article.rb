class Article < ActiveRecord::Base
  
  include AASM

  aasm do
  	state :draft, :initial => true
  	state :published

  	event :publish, before: ->{ self.updated_at = Time.now } do
  	  transitions from: :draft, to: :published
  	end

  	event :draft do
  	  transitions from: :published, to: :draft
  	end
  end
  
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  mount_uploader :image, ImageUploader


end
