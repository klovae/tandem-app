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

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your information has been updated."
      redirect_to welcome_path
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :timezone)
  end

end