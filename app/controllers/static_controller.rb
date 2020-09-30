class StaticController < ApplicationController
  skip_before_action :auth_required, only: [:index, :about]

  def index
  end

  def about
  end

  def help
  end

end