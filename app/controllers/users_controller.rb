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
        redirect_to home_path
    else
        flash.now[:errors] = @user.errors.full_messages
        render :new
    end

  end

  def show
    @user_projects = current_user.user_projects
    @tasks = Assignment.user_list(current_user)[0..9]
    invites = current_user.permissions.where(accepted: false)
    if invites.present?
      @invitations = invites
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your information has been updated."
      redirect_to home_path
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :timezone)
  end

end