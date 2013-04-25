class FeedSerializer < ActiveModel::Serializer
  attributes :name, :lat, :lng, :slug
end
