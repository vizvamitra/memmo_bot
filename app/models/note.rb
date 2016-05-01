class Note < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags

  scope :recent, ->{ order(created_at: :desc) }

  validates :text, presence: true
  validates :user, presence: true
end
