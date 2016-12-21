class TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      flash[:success] = 'Liste erfolgreich angelegt!'
      redirect_to :todo_lists
    else
      flash[:danger] = @todo_list.errors.full_messages
      render :new
    end
  end

  def edit
    @todo_list = TodoList.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list.update_attributes(todo_list_params)
      flash[:success] = 'Liste erfolgreich geändert!'
      redirect_to :todo_lists
    else
      flash[:danger] = @todo_list.errors.full_messages
      render :edit
    end
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
