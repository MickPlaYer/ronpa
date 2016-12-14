class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.text :content, null: false
      t.integer :tag, null: false, default: 0

      t.timestamps
    end
  end
end
