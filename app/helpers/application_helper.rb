module ApplicationHelper
  def controller_assets
    controller = params[:controller]
    if  Rails.application.config.controllers_with_assets.include? controller
      javascript_include_tag controller, 'data-turbolinks-track' => true
    end
  end
end
