class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :url
      t.string :provider
      t.integer :cat

      t.timestamps
    end
  end
end
