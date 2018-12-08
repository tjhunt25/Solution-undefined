class Comment < ApplicationRecord
  belongs_to :solution, optional: true
  belongs_to :user, optional: true
end
