class SessionsController < ApplicationController
  skip_before_action :auth_required, only: [:new, :create]
  require 'securerandom'

  def new
  end

  def create
    if auth
      @user = User.find_or_create_by!(uid: auth['uid']) do |u|
        u.first_name = auth['info']['name'].split(" ", 2)[0]
        u.last_name = auth['info']['name'].split(" ", 2)[1]
        u.email = auth['info']['email']
        u.password = SecureRandom.alphanumeric(10)
      end

      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{current_user.first_name}!"
      redirect_to home_path

    else
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Welcome, #{current_user.first_name}!"
        redirect_to home_path
      else
        flash.now[:error] = "Sorry, your username and/or password is not correct"
        render :new
      end
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end