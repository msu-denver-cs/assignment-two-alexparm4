class Part < ApplicationRecord
    has_and_belongs_to_many :cars   #Establishes many-many relationship
                                    #between Part and cars tables.
end
