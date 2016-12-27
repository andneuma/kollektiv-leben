class TodoListsController < ApplicationController
  before_action :check_if_signed_in
  before_action :scope_to_current_group
  before_action :get_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    @todo_lists = @group.todo_lists.all
  end

  def new
    @todo_list = @group.todo_lists.new
    render 'form_modal'
  end

  def edit
    @todo_list = @group.todo_lists.find(params[:id])
    render 'form_modal'
  end

  def create
    @todo_list = @group.todo_lists.build(todo_list_params)
    if !@todo_list.save
      render json: @todo_list.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def update
    if !@todo_list.update_attributes(todo_list_params)
      render json: @todo_list.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def destroy
    if !@todo_list.destroy
      flash[:danger] = 'Ooops, etwas ist schiefgegangen, bitte kontaktiere den_die Administrator_in!!'
    end
  end

  private

  def get_todo_list
    @todo_list = @group.todo_lists.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
