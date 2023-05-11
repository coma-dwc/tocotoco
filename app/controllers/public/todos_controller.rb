class Public::TodosController < ApplicationController

  def new
    @todo = Todo.new
  end

  def index
    @todos = Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    @todo.save
    redirect_to todos_path
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    redirect_to todos_url
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_url
  end

  private

  def todo_params
  params.require(:todo).permit(:task)
  end
end
