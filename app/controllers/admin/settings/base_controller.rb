class Admin::Settings::BaseController < AuthorizedController

  before_filter do
  	add_breadcrumb_admin
  	add_breadcrumb('設定', edit_admin_settings_profiles_path)
  end
end