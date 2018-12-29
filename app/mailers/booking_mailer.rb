class BookingMailer < ApplicationMailer

	def send_conformation_email_to_teacher(teacher, lesson)
		@recipient = teacher
		@lesson = lesson
		mail(to: recipient.email, subject: "Your lesson is booked! 🙌 🍎" )
	end
end
