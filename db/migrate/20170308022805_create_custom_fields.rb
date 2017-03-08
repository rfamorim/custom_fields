class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :name
      t.integer :field_type
      t.text :options, array: true, default: []
      t.datetime :deleted_at
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
