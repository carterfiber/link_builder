class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :reg_url
      t.string :src_name
      t.string :pfm_name
      t.string :opt_identifier

      t.timestamps
    end
  end
end
