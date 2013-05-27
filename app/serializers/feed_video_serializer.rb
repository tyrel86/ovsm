class FeedVideoSerializer < ActiveModel::Serializer
  attributes :id, :feed_id, :video, :active
end
