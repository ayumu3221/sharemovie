class CreateListComments < ActiveRecord::Migration[6.1]
  def change
    create_table :list_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :list_id
      
      t.timestamps
    end
  end
end
