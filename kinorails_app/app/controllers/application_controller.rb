class ApplicationController < ActionController::Base
    # Uncomment if you want user to login every time
    # he enters any of pages
    # before_action :authenticate_user!

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
       devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :name, :surname, :phone_number])
    end

end
