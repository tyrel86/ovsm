CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJSLIJBBBDOMHPMPA',       # required
    :aws_secret_access_key  => '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',      # required
  }
  config.fog_directory  = 'overseame'
end

#Automatically include custome carrier wave processors
dir = Rails.root.join('lib', 'carrierwave_processing')
$LOAD_PATH.unshift(dir)
Dir[File.join(dir, "*.rb")].each {|file| require File.basename(file) }
