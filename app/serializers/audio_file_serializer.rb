class AudioFileSerializer < ActiveModel::Serializer
  attributes :id, :mp3_url, :oga_url, :name
end
