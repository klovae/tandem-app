class StaticController < ApplicationController
  skip_before_action :auth_required, only: [:index, :about]

  def welcome
  end

  def index
  end

  def about
  end

end