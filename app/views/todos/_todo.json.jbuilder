json.extract! todo, :id, :title, :user_id, :due_on, :completed_on, :created_at,
              :updated_at
json.url todo_url(todo, format: :json)
