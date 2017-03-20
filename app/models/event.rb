class Event < ApplicationRecord
  belongs_to :sub_category
  validates :occurs_at, presence: true, uniqueness: { scope: :headline }
  validates :headline, presence: true
  # validates :valid

end

