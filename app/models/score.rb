class Score < ApplicationRecord
    belongs_to :user
    has_many :beats, dependent: :destroy

    validates :title, presence: true
    validates :artist, presence: true
end
