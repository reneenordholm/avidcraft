class ChangeNameToTitleOnItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :name, :title
  end
end
