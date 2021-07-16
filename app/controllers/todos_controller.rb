class TodosController < ApplicationController
  before_action :current_user_must_be_todo_user,
                only: %i[edit update destroy]

  before_action :set_todo, only: %i[show edit update destroy]

  def index
    @q = Todo.ransack(params[:q])
    @todos = @q.result(distinct: true).includes(:user).page(params[:page]).per(10)
  end

  def show; end

  def new
    @todo = Todo.new
  end

  def edit; end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      message = "Todo was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @todo, notice: message
      end
    else
      render :new
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @todo.destroy
    message = "Todo was successfully deleted."
    if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
      redirect_back fallback_location: request.referer, notice: message
    else
      redirect_to todos_url, notice: message
    end
  end

  private

  def current_user_must_be_todo_user
    set_todo
    unless current_user == @todo.user
      redirect_back fallback_location: root_path,
                    alert: "You are not authorized for that."
    end
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :user_id, :due_on, :completed_on)
  end
end
