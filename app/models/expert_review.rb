class ExpertReview < Review
	belongs_to :expert, class_name: "User"
end
