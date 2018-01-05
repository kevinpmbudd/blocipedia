class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true
  validates :user, presence: true

end
