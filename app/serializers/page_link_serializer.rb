class PageLinkSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image_url
end
