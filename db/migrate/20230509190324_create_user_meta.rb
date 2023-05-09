class CreateUserMeta < ActiveRecord::Migration[7.0]
  def change
    create_table :user_meta do |t|
      t.integer :user_id
      t.string :meta_key
      t.string :meta_value

      t.timestamps
    end
  end
end
