class AddFinalUrlToLinks < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :final_url, :string
  end
end
