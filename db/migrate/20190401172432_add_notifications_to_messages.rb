class AddNotificationsToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :notification, :boolean, :default => false
  end
end