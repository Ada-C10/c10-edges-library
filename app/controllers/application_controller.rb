class ApplicationController < ActionController::Base

  before_action :find_logged_in_author

  private

  def find_logged_in_author
    @logged_in_author = Author.find_by(id: session[:user_id])
  end

end
