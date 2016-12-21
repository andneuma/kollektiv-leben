class GroupsController < ApplicationController
  before_action :require_valid_registration_token, only: [:create]
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :require_to_be_same_group, only: [:edit, :update, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:success] = 'Gruppe erfolgreich angelegt!'
      redirect_to root_url
    else
      flash[:danger] = @group.errors.full_messages
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Änderungen erfolgreich übernommen"
      redirect_to edit_group_url(@group)
    else
      flash[:danger] = @group.errors.full_messages
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:success] = 'Gruppe gelöscht!'
    end
  end

  private

  def token_valid?(token)
    Group.registration_tokens.include? token
  end

  def remove_from_registration_tokens(token)
    group = Group.where("? = ANY (registration_tokens)", token).first
    group.registration_tokens.delete token
    group.save
  end

  def require_valid_registration_token
    token = params[:registration_token]
    if token && token_valid?(token)
      remove_from_registration_tokens token
    else
      flash[:danger] = 'Registrierungs-Code ungültig oder nicht angegeben!'
      render :new
    end
  end

  def require_to_be_same_group
    group_to_be_edited = Group.find(url_options[:_recall][:id])
    redirect_to root_url unless group_to_be_edited.id == current_group.id
  end

  def require_login
    unless session[:group_id]
      flash[:danger] = 'Bitte zuerst einloggen!'
      redirect_to login_url
    end
  end

  def group_params
    params.require(:group).permit(:name, :email, :password, :password_confirmation)
  end
end
