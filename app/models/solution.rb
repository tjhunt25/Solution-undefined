class Solution < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments
  belongs_to :challenge, optional: true

end
