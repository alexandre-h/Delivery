class Rider < ApplicationRecord
  has_many :orders

  validates_presence_of :x, :y
end
