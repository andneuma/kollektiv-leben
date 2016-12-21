class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: [:show, :edit, :update]

  def index
    @todo_items = @todo_list.todo_items
  end

  def new
    @todo_item = @todo_list.todo_items.new
  end

  def show
  end

  def create
    @todo_item = @todo_list.todo_items.build(todo_item_params)

    if @todo_item.save
      flash[:success] = 'Neue Aufgabe erfolgreich angelegt!'
      redirect_to todo_list_url(@todo_list)
    else
      flash[:danger] = @todo_item.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @todo_item.update_attributes(todo_item_params)
      flash[:success] = 'Änderungen erfolgreich übernommen!'
      redirect_to todo_list_path(@todo_list)
    else
      flash[:danger] = @todo_item.errors.full_messages
      render :edit
    end
  end

  def destroy
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
