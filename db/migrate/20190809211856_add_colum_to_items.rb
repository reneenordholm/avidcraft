class AddColumToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :image, :string
  end
end
