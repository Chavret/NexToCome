class SubCategory < ApplicationRecord

  belongs_to :category
  has_many :events, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
