class Event < ApplicationRecord
  belongs_to :sub_category
  has_one :category, through: :sub_category

  validates :occurs_at, presence: true, uniqueness: { scope: :headline }
  validates :headline, presence: true
  # validates :valid
  paginates_per 50
end

