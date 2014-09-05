class RemoveUselessColumnsFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :image_path, :string
    remove_column :images, :thumbnail_path, :string
  end
end
