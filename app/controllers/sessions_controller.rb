class SessionsController < ApplicationController
  skip_before_action :auth_required, only: [:new, :create]

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{current_user.first_name}!"
      redirect_to welcome_path
    else
      flash.now[:error] = "Sorry, your username and/or password is not correct"
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

end