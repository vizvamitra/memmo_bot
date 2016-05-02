class User < ApplicationRecord
  has_secure_token :callback_token

  KNOWN_LANGUAGES = ['en', 'ru']

  has_many :notes
  has_many :tags, through: :notes

  validates :telegram_id, presence: true
  validates :language, inclusion: KNOWN_LANGUAGES
end
