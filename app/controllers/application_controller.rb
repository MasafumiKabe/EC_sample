class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_user_logged_in
    unless user_signed_in?
      redirect_to root_url
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url = result['itemUrl']
    image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')

    {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end

end
