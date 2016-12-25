class TodoListsController < ApplicationController
  before_action :get_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    @todo_lists = TodoList.all
  end

  def new
    @todo_list = TodoList.new
    3.times { @todo_list.todo_items.build }
    render 'form_modal'
  end

  def edit
    3.times { @todo_list.todo_items.build }
    render 'form_modal'
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
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
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
