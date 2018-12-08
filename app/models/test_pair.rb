class TestPair < ApplicationRecord
  belongs_to :challenge
  enum input_type: [:integer, :string, :array], _suffix: true
  enum output_type: [:integer, :string, :array], _prefix: :output
end
