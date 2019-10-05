class Car < ApplicationRecord
  belongs_to :make                      
  has_and_belongs_to_many :parts 
                                  
  validates_associated :parts           #Validates :parts at the same time
  validates :make, presence: true       #Checks presence of a make 
  validates :parts, presence: true      #Checks presence of parts 
  validates :model, length: {minimum: 2}      #Checks presence of model
  validates :vin, uniqueness: true, length: {minimum: 11, maximum: 17}, format: {with: /\A[0-9A-Z]*\z/, message: "only accepts upper-case letters and numbers"}
                                        #Checks uniquness and length req's for a VIN, also numerals and capitalized letters only
                                        #SOURCE: Slides 14-17 from 07DebugValidationCSS
                                        #SOURCE for regular expression help: https://stackoverflow.com/questions/24422018/rails-validates-with-regex-is-not-working

  
end                                     
