require 'rails_helper'

RSpec.describe 'お知らせ登録', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    user = create(:employee, department: department, office: office)
    sign_in_as user
    visit new_post_path
  end

  describe '・お知らせの登録ができる。' do
    it 'is success!' do
      expect { register_post }.to change(Post, :count).by(1)
    end
  end

  describe '・保存ボタンをクリックしたとき、バリデーションチェックを行う。' do
    scenario "・タイトル：入力されているか？ ： 'タイトルが入力されていません'" do
      find('#submit_save').click

      expect(page).to have_selector '.post_space ul li', text: 'タイトルが入力されていません'
    end

    scenario "・タイトル：50文字以内か？ ： 'タイトルは50文字以内で入力してください'" do
      fill_in 'post[title]', with: '012345678901234567890123456789012345678901234567890'
      find('#submit_save').click

      expect(page).to have_selector '.post_space ul li', text: 'タイトルは50文字以内で入力してください'
    end
  end

  describe '・登録した後、一覧画面に遷移する' do
    before do
      register_post
    end

    it 'is success!' do
      expect(current_path).to eq posts_path
    end
  end
end
