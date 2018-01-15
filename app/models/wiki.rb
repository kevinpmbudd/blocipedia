class Wiki < ApplicationRecord
  belongs_to :user

  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 3 }, presence: true
  validates :body, length: { minimum: 15 }, presence: true
  validates :user, presence: true

  def public?
    !self.private?
  end
end
