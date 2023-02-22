class List < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  
    validates :body,presence:true,length:{maximum:200}
    
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end
    
  def self.search_for(content, method)
    if method == 'perfect'
      List.where(title: content)
    elsif method == 'forward'
      List.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      List.where('title LIKE ?', '%'+content)
    else
      List.where('title LIKE ?', '%'+content+'%')
    end
  end    
end
