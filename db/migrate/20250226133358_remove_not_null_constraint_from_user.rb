class RemoveNotNullConstraintFromUser < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :name, true
    change_column_default :users, :name, nil
  end
end
