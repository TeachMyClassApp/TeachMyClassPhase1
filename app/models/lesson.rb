class Lesson < ApplicationRecord
	enum instant: {Request: 0, Instant: 1}
	enum pricing_type: {Session: 0, Learner: 1, Free: 2}

	belongs_to :user
	has_many :photos
	has_many :bookings

	has_many :teacher_reviews
	has_many :calendars

	geocoded_by :address
	after_validation :geocode, if: :address_changed?


	validates :learning_area, presence: true
	validates :achievement_objective, presence: true
	validates :curriculum_level, presence: true
	validates :class_size, presence: true

	def cover_photo(size)
		if self.photos.length > 0
			self.photos[0].image.url(size)
		else
			"blank.jpg"
		end
	end  


def average_rating
		teacher_reviews.count == 0 ? 0 : teacher_reviews.average(:star).round(2).to_i
end
end
