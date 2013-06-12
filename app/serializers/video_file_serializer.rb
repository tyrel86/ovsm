class VideoFileSerializer < ActiveModel::Serializer
  attributes :id, :webm_url, :mp4_url, :ogv_url
end
