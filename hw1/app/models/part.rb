class Part < ApplicationRecord
    has_and_belongs_to_many :cars
    validates :name, uniqueness: true, length: {minimum: 2}     #Added validations to check part name uniquness and the minimum length of 2 character
end
