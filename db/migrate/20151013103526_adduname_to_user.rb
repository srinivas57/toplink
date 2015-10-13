class AddunameToUser < ActiveRecord::Migration
  def change
    add_column :users, :uname, :string
  end
end
