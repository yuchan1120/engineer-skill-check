require 'rails_helper'

RSpec.describe 'お知らせ参照', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    user = create(:employee, department: department, office: office)
    @post = create(:post, employee: user)
    sign_in_as user
    visit post_path(@post)
  end

  describe '・お知らせの記事を表示する。' do
    it 'is success!' do
      expect(page).to have_selector '#title', text: @post.title
      expect(page).to have_selector '#content', text: @post.content
    end
  end

  describe '・一覧に戻るボタンをクリックしたときに、一覧画面へ遷移する。' do
    it 'is success!' do
      find('#link_posts_btn').click

      expect(current_path).to eq posts_path
    end
  end
end
