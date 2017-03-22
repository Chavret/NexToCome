class SubCategory < ApplicationRecord
  belongs_to :category, optional: true
  has_many :events
  validates :name, presence: true
end
