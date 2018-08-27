class Movie < ApplicationRecord
    has_and_belongs_to_many :genres
    has_many :reviews, dependent: :destroy
end
