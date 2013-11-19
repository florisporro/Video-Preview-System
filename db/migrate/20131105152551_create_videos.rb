class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :description
      t.string :videolink
      t.timestamp :time

      t.timestamps
    end
  end
end
