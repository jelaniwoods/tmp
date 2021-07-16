class TodoResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :title, :string
  attribute :user_id, :integer
  attribute :due_on, :datetime
  attribute :completed_on, :datetime

  # Direct associations

  belongs_to :user

  # Indirect associations
end
