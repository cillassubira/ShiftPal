class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  #before_action :signed_in_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:sign_up) << :alias
    end

    def after_sign_in_path_for(user)
      user_shifts_path(user)
    end

    # def signed_in_user
    #   unless current_user
    #     redirect_to root_path, notice: 'Access forbidden.'
    #   end
    # end

  protect_from_forgery with: :exception
end
