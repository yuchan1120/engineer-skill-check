require 'rails_helper'

RSpec.describe 'メイン', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @user = create(:employee, department: department, office: office)
    sign_in_as @user
  end

  describe '・上部にメニューバーを表示する。' do
    scenario '・メニューにはお知らせと社員紹介を表示する。' do
      expect(page).to have_selector '#link_posts_header', text: 'お知らせ'
      expect(page).to have_selector '#link_employees_header', text: '社員紹介'
    end

    scenario '・メニューバーの右側にログインしているユーザ名を表示する。' do
      expect(page).to have_selector '#dropdown__btn', text: "#{@user.last_name} #{@user.first_name}"
    end
  end

  describe '・ユーザ名をクリックしたときにプルダウンメニューを表示する。' do
    it 'is pending.' do
      pending('Docker環境にchrome未導入のため')
      find('#dropdown_menu').click

      expect(page).to have_selector '#is-open'
    end

    scenario '・プルダウンメニューのログアウトをクリックしたとき、ログアウトして、ログイン画面に遷移する。' do
      find('#link_logout').click

      expect(current_path).to eq login_path
    end
  end
end
