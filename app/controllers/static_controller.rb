class StaticController < ApplicationController
  skip_before_action :auth_required, only: [:index, :about]

  def welcome
    invites = current_user.permissions.where(accepted: false)
    if invites.present?
      @invitations = invites
    end
  end

  def index
  end

  def about
  end

end