class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable 

  validates :username, presence: true, length: {minimum: 2, maximum: 50}

  has_many :lessons
  has_many :bookings

  has_many :expert_reviews, class_name: "ExpertReview", foreign_key: "expert_id"
  has_many :teacher_reviews, class_name: "TeacherReview", foreign_key: "teacher_id"
  has_many :notifications

  mount_uploader :avatar, AvatarUploader

  has_one :setting
  after_create :add_setting

  def add_setting
    Setting.create(user: self, enable_sms: true, enable_email: true)
  end

  def self.from_omniauth(auth)
  	user = User.where(email: auth.info.email).first

  	if user
  		return user
  	else
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		    user.email = auth.info.email
		    user.password = Devise.friendly_token[0,20]
		    user.username = auth.info.name   
		    user.image = auth.info.image 
		    user.uid = auth.uid
		    user.provider = auth.provider
		    #
		    # If you are using confirmable and the provider(s) you use validate emails, 
		    # uncomment the line below to skip the confirmation emails.
		     user.skip_confirmation!
  	end
	end
  end 


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    user = User.where(:provider => access_token.provider, :uid=> access_token.uid).first

    return user if user

    registered_user = User.where(:email => access_token.info.email).first
    return registered_user if registered_user

    where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
      user.email = access_token.info.email,
      user.password = Devise.friendly_token[0,20],
      user.username = access_token.info.name,   
      user.image = access_token.info.image,
      user.uid = access_token.uid,
      user.provider = access_token.provider
      #
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
       user.skip_confirmation!
    end
  end 

  def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save 
  end

  def send_pin
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV["TWILIO_PHIONE_NUMBER"],
      to: self.phone_number,
      body: "Your Teach My Class verification code is: #{self.pin}. Welcome!"
      )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if self.pin == entered_pin
  end 
end

