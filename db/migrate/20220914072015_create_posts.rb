class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :employee,   null: false
      t.string     :title,      null: false
      t.text       :content
      t.datetime   :deleted_at, null: true,   default: nil

      t.timestamps
    end
    add_foreign_key :posts, :employees
  end
end
