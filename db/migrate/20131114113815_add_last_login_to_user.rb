class AddLastLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :lastlogin, :time
  end
end
