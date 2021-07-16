class Api::V1::TodosController < Api::V1::GraphitiController
  def index
    todos = TodoResource.all(params)
    respond_with(todos)
  end

  def show
    todo = TodoResource.find(params)
    respond_with(todo)
  end

  def create
    todo = TodoResource.build(params)

    if todo.save
      render jsonapi: todo, status: :created
    else
      render jsonapi_errors: todo
    end
  end

  def update
    todo = TodoResource.find(params)

    if todo.update_attributes
      render jsonapi: todo
    else
      render jsonapi_errors: todo
    end
  end

  def destroy
    todo = TodoResource.find(params)

    if todo.destroy
      render jsonapi: { meta: {} }, status: :ok
    else
      render jsonapi_errors: todo
    end
  end
end
