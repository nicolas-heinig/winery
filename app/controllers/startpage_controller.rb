class StartpageController < ApplicationController
  def index
  end

  def role_switch
    redirect_to root_path unless Rails.env.development?

    current_user.update!(role: params[:role].to_i)

    redirect_back fallback_location: root_path
  end
end