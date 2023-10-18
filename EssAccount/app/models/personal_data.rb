class PersonalData < ApplicationRecord
  has_many :employments, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
end
