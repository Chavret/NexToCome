class Category < ApplicationRecord
  has_many :sub_categories
  validates :name, presence: true
  acts_as_votable
end
