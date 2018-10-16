class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
    if user
      # Found an existing user
      flash[:success] = "Logged in as existing user #{user.username}"

    else
      # New user - try to create
      user = User.new(
        uid: auth_hash['uid'],
        provider: auth_hash['provider'],
        username: auth_hash['info']['nickname'],
        image_url: auth_hash['info']['image']
      )

      if user.save
        flash[:success] = "Logged in as existing user #{user.username}"
      else
        flash[:error] = "Could not create new account: #{user.errors.messages}"
        redirect_to root_path
        return
      end
    end

    session[:user_id] = user.id
    redirect_to root_path
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
