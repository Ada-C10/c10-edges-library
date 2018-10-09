class SessionsController < ApplicationController
  def new
  end

  def create
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
end
