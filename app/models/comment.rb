class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :li
    
    validates :comment, presence: true
end
