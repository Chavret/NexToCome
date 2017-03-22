class SubCategory < ApplicationRecord

  belongs_to :category, optional: true
  has_many :events
  validates :name, presence: true, uniqueness: true

  
  acts_as_votable


end
