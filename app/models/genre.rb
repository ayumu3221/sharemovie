class Genre < ApplicationRecord
  has_many :lists
  
  scope :only_active, -> { where(is_active: true) }

  validates :name, presence: true
end
