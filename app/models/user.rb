class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable,
				 :authentication_keys => [:login], :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :name, :username, :interest_id, :email, :password, :password_confirmation, :remember_me
	attr_protected :id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count,
								 :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at

	attr_accessor :login, :lat, :lng

	mount_uploader :avatar, AvatarUploader
	belongs_to :interest
	belongs_to :feed
	has_many :posts, :dependent => :destroy
	has_many :landscape_photos
	has_many :portrait_photos
	has_many :square_photos
	has_many :video_files
	has_many :audio_files
	has_many :suitcases

	before_create :set_home_town, :add_a_starter_suitcase

	def set_home_town
		latlng = [lat, lng]
		unless latlng.first.nil? or latlng.last.nil?
			self.feed = Feed.closest( origin: latlng ).first
		else
			#Default to user profile home town for now denver soon based on user settings
			self.feed = Feed.find_by_name( "Denver, CO" )
		end
	end

	def add_a_starter_suitcase
		self.suitcases.build( name: "My First Suitcase" )
	end

	def suit_case_post_ids
		ids = []
		suitcases.each {|s| ids += s.post_ids}
		ids.uniq
	end

	class << self
		def authenticate(login, password)
      if (user = where{ (email == login) | (username == login) }.first) and user.valid_password? password
      	user
      else
      	nil
			end
    end
		def find_first_by_auth_conditions(warden_conditions)
			conditions = warden_conditions.dup
			if login = conditions.delete(:login)
				where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
			else
				where(conditions).first
			end
		end

		def find_for_facebook_oauth(auth, signed_in_resource=nil)
			user = User.where(:provider => auth.provider, :uid => auth.uid).first
			unless user
				birthday_string = auth.extra.raw_info.birthday
				birthday = Date.strptime(birthday_string, "%m/%d/%Y")
				avatar_url = auth.info.image.gsub("square","large")
				user = User.new(name: auth.extra.raw_info.name,
														 provider: auth.provider,
														 uid: auth.uid,
														 email: auth.info.email,
														 birthday: birthday,
														 username: auth.extra.raw_info.username,
														 password: Devise.friendly_token[0,20]
														 )
				user.remote_avatar_url = avatar_url
				user.save
			end
			user
		end
	end

end
