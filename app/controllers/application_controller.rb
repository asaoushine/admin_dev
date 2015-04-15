class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  before_filter do
  	@breadcrumbs = []
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :wrap_transaction, only: [:create, :update, :destroy]

  def add_breadcrumb_admin
  	add_breadcrumb('管理画面', admin_path)
  end

  def add_breadcrumb(label, link = nil)
  	@breadcrumbs << [label, link]
  end

  def after_sign_in_path_for(resource)
    admin_path
  end



  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:screen_name, :icon, :remote_icon_url, :email, :encrypted_password, :password) }    	
    end

  private

    def wrap_transaction
      ActiveRecord::Base.transaction do
      	yield
      end
    end
end
