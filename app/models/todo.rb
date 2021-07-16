class Todo < ApplicationRecord
  # Direct associations

  belongs_to :user

  # Indirect associations

  # Validations

  validates :title, presence: true

  # Scopes

  def to_s
    title
  end
end
