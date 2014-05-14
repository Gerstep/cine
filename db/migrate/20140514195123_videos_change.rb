class VideosChange < ActiveRecord::Migration
  def change
  	remove_column :videos, :cat, :integer
  end
end
