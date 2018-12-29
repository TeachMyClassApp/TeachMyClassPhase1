class Upload < ApplicationRecord
	belongs_to :user
	has attached_file :image, styles: {medium: "300x300>", thumb: "120x120>"}, default:
	validates_attachment_content_type :image, content_type: /\
end
