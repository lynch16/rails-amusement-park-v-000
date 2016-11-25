class UsersController < ApplicationController

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if !!@user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(current_user)
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(current_user)
      else
        redirect_to root_path, alert: 'Error signing up'
      end
    end
  end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end

  def signin
    @user = User.new
  end

  def destroy
    session.clear
    redirect_to root_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
  end

end
