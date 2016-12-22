class SessionsController < ApplicationController
  def new
  end

  def create
    @group = Group.find_by(name: params[:sessions][:name])

    if @group && @group.authenticated?(attribute: "password", token: params[:sessions][:password])
      session[:group_id] = @group.id
      redirect_to root_url
      flash[:success] = 'Herzlich willkommen!'
    else
      flash[:danger] = 'Username oder Passwort falsch!' 
      render :new
    end
  end

  def destroy
    session[:group_id] = nil
    redirect_to root_url
    flash[:success] = "Tschüssikowski!"
  end

  private

  def session_params
    params.require(:sessions).permit(:name, :email, :password)
  end
end
