class AddSiteToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :site, :text
  end
end
