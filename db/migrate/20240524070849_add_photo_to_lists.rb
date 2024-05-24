class AddPhotoToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :photo, :string
  end
end
