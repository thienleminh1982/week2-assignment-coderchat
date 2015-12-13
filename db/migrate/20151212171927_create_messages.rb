class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.references :sender, index: true
      t.references :recipient, index: true
      t.boolean :is_read

      t.timestamps null: false
    end
  end
end
