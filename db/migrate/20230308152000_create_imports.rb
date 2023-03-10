class CreateImports < ActiveRecord::Migration[7.0]
  def change
    create_table :imports do |t|
      t.string :file_name
      t.integer :total_rows
      t.integer :status
      t.integer :success_count
      t.integer :error_count
      t.text :error_messages

      t.timestamps
    end
  end
end
