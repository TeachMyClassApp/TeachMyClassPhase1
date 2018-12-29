class TeacherReview < Review
		belongs_to :teacher, class_name: "User"
end
