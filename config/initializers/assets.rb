Rails.application.config.assets.version = '1.0'

Rails.application.config.controllers_with_assets = %w( tasks welcome )
Rails.application.config.controllers_with_assets.each do |controller|
  Rails.application.config.assets.precompile += ["#{controller}.coffee"]
end