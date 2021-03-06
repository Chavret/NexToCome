class Category < ApplicationRecord

  has_many :sub_categories, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  has_many :event, through: :categories
  acts_as_votable

end
