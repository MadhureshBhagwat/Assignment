class Employment < ApplicationRecord
  belongs_to :personal_data

  validates :employer, presence: true
  validates :date_started, presence: true
  validates :date_ended, presence: true
end
