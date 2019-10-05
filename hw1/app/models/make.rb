class Make < ApplicationRecord
  has_many :cars    
  validates :name, uniqueness: true, length: {minimum: 2}
  validates :country, length: {minimum: 3}
end
