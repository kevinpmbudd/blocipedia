class AddDefaultPrivateToWikis < ActiveRecord::Migration[5.1]
  def change
    change_column_default :wikis, :private, false
  end
end
