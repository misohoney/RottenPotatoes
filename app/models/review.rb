class Review < ApplicationRecord
    belongs_to :movie
    validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :user_name, presence: true
    validates :comment, presence: true

end
