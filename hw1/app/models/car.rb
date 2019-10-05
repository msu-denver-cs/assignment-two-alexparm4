class Car < ApplicationRecord
  belongs_to :make                      
  has_and_belongs_to_many :parts   #Added to establish the many-many relationship
                                  #between Car and Part
                                  
  validates_associated :parts
  validates :make, presence: true
  validates :parts, presence: true
  validates :model, presence: true
  validates :vin, uniqueness: true, length: {minimum: 11, maximum: 17}
end