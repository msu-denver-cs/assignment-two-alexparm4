class Make < ApplicationRecord
  has_many :cars    #this sets up the one-many relationship for the Car and
                    #Make classes; so one Make can belong to many Cars, 
                    #but each Car has only one Make

  validates :name, uniqueness: true, length: {minimum: 2}

end
