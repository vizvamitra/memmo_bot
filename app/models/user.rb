class User < ApplicationRecord
  has_many :notes

  validates :telegram_id, presence: true
end
