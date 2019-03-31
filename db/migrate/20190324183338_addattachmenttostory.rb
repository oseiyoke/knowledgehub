class Addattachmenttostory < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :attachment, :string
  end
  
end
