class TodoListsController < ApplicationController
  before_action :get_todo_list, only: [:show, :edit, :update, :destroy]

  def index
    @todo_lists = TodoList.all
  end

  def show
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      flash[:success] = t('.created')
      redirect_to :todo_lists
    else
      flash[:danger] = @todo_list.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @todo_list.update_attributes(todo_list_params)
      flash[:success] = t('.updated')
      redirect_to :todo_lists
    else
      flash[:danger] = @todo_list.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @todo_list.destroy
      flash[:warning] = t('.destroyed')
    else
      flash[:danger] = t('.error')
    end
    redirect_to todo_lists_url
  end

  private

  def get_todo_list
    @todo_list = TodoList.find(params[:id])
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
