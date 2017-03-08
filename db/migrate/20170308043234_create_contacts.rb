class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.hstore :custom_fields
      t.datetime :deleted_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
