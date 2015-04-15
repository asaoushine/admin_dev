class Admin::Settings::PasswordsController < Admin::Settings::BaseController

  before_filter do
  	add_breadcrumb('パスワード設定')
  end

  def edit
  	@change_password = ChangePassword.new
  end

  def update
  	@change_password = ChangePassword.new params[:change_password]
  	@change_password.valid?

  	unless current_user.valid_password?(@change_password.current_password)
  	  @change_password.errors.add(:current_password, 'が違います')
  	end

  	if @change_password.new_password != @change_password.new_password_confirmation
  		@change_password.errors.add(:new_password_confirmation, 'が同じではありません')  		
  	end

  	render action: :edit and return if @change_password.errors.any?

  	current_user.password = @change_password.new_password
  	current_user.save!

  	# この一行を加える事で、再ログインさせている。
  	sign_in(current_user, bypass: true)

  	flash[:success] = '変更しました'
  	redirect_to action: :edit

  end


end
