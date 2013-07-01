class PostSerializer < ActiveModel::Serializer
  attributes :content, :exerpt, :created_at, :updated_at, :id, :promotional,
						 :promo_price, :promo_discounted_price, :promo_description, :promo_street_address, :promo_city,
						 :promo_state, :promo_zip, :promo_start_date, :promo_end_date, :promo_labor_characteristic,
						 :promo_free, :promo_wage, :promo_wage_time, :promo_shipping_cost, :promo_href, :promo_image, :promo_name,
						 :location_type, :promo_contact_email, :promo_type

	has_one :user
	has_one :business
	has_one :photo_album
	has_one :audio_album
	has_one :video_album
	has_many :page_links
end
