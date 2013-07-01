class Business < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :business_name, :business_banner, :business_logo,
									:street_address, :city, :state, :zip_code, :phone, :feed_id
  # attr_accessible :title, :body

	belongs_to :feed
	has_many :posts

	mount_uploader :business_logo, BusinessLogoUploader
	mount_uploader :business_banner, BusinessBannerUploader
end
