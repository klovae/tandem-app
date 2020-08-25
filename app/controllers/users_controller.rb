class UsersController < ApplicationController
  skip_before_action :auth_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Account created successfully. Welcome to Tandem!"
        redirect_to welcome_path
    else
        flash[:errors] = @user.errors.full_messages
        render :new
    end

  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :timezone)
  end

end