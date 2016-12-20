class Profile < ActiveRecord::Base
    belongs_to :user
    validates :user, presence: true
    validates :first_name presence: { message:"You must enter a first name"}
    validates :last_name presence: {messages: "You must enter a last name"}
    validates :phone_number, numericality: {only_integer: true}
    validates :description, length: {maximum: 500}
    
    
end