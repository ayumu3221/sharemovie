class CreateCommeents < ActiveRecord::Migration[6.1]
  def change
    create_table :commeents do |t|

      t.timestamps
    end
  end
end
