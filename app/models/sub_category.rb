class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :events
  validates :name, presence: true
  acts_as_votable
end
