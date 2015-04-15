class UsersController < ApplicationController
  
  before_action :set_user, only: [:index, :show]

  def index
  	@users = User.all
  end

  def show
  	
  end

  private

   def set_user
      @user = User.where(screen_name: params[:id]).first
   end

    
end
