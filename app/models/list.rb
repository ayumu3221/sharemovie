class List < ApplicationRecord
    belongs_to :user
    belongs_to :genre
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
  
    validates :body,presence:true,length:{maximum:200}
    
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    
end
