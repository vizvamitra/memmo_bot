class User < ApplicationRecord
  has_many :notes
  has_many :tags, through: :notes

  validates :telegram_id, presence: true
  validates :language, inclusion: SUPPORTED_LANGUAGES
end
