class Score < ApplicationRecord
    belongs_to :user
    has_many :beats, dependent: :destroy
end
