class AddNewsPostingAuthToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :news_posting_auth, :boolean, null: false, default: false
  end
end
