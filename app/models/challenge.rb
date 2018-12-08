class Challenge < ApplicationRecord
  belongs_to :user, optional: true
  has_many :solutions
  has_many :test_pairs
  validates :name, presence: true
end
