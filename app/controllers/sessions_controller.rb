class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    binding.pry
  end

  def create_old
    name = params[:author_name]
    author = Author.find_by(name: name)

    if author
      flash[:success] = "Successfully logged in as #{name}"
      session[:user_id] = author.id
      redirect_to author_path(author)

    else
      flash.now[:error] = "No such author \"#{name}\""
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end
end
