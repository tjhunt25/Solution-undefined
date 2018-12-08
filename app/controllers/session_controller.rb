class SessionController < ApplicationController
  def create
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate(params[:password])

      session[:user_id] = user.id

      redirect_to user_path(user.id)

    else
 # Bad credentials, i.e unsuccessful login

   flash[:error] = "Invalid email address or password"
   redirect_to (login_path)
  end
end

  def destroy
    session[:user_id] = nil
    redirect_to login_path

  end
end
