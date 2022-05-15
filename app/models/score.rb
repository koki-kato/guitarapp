class Score < ApplicationRecord
    has_many :beats, dependent: :destroy
end
