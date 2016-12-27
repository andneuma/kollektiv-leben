class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  def new
    @todo_item = @todo_list.todo_items.new
    render 'form_modal'
  end

  def create
    @todo_item = @todo_list.todo_items.build(todo_item_params)

    if !@todo_item.save
      render json: @todo_item.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def edit
    render 'form_modal'
  end

  def update
    if !@todo_item.update_attributes(todo_item_params)
      render json: @todo_item.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  def destroy
    if !@todo_item.destroy
      flash[:danger] = 'Ooops, etwas ist schiefgegangen, bitte kontaktiere den_die Administrator_in!!'
    end
  end

  private

  def todo_item_params
    params.require(:todo_item).permit(:name, :description, :start_date, :end_date, :completed)
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
end
