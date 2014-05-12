

CarrierWave.configure do |config|
  config.fog_credentials = {


    provider: "AWS",aws_access_key_id: 'AKIAIUQSOVUNUEUQQXMQ',
    aws_secret_access_key: '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'



  }

  config.fog_directory = "propheticcoaching-staging"
end

