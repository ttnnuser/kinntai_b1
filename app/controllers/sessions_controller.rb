class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash.now[:danger] = "メールアドレスとパスワードの情報が一致しませんでした。"
      render 'new'
    end
  end
  def delete
    log_out
    redirect_to root_url
  end  
end
