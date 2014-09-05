class CreateImage < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_path
      t.string :thumbnail_path
      t.string :origin
    end
  end
end
