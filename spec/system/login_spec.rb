require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @user = create(:employee, department: department, office: office)
    visit login_path
  end

  describe '・アカウントとパスワードでログインする。' do
    it 'is success!' do
      sign_in_as @user

      expect(page).to have_selector '#dropdown__btn', text: "#{@user.last_name} #{@user.first_name}"
    end
  end

  describe '・ログインボタンをクリックしたとき、アカウントとパスワードのチェックを行う。' do
    scenario "・アカウントが入力されていない場合、下記のメッセージ 'アカウントが入力されていません。' を表示する。" do
      fill_in 'employees[password]', with: @user.password
      find('#submit_login').click

      expect(page).to have_selector '#flash_alert', text: 'アカウントが入力されていません。'
    end

    scenario "・パスワードが入力されていない場合、下記のメッセージ 'パスワードが入力されていません。' を表示する。" do
      fill_in 'employees[account]', with: @user.account
      find('#submit_login').click

      expect(page).to have_selector '#flash_alert', text: 'パスワードが入力されていません。'
    end

    scenario "・アカウントとパスワードが一致しない場合、下記のメッセージ 'アカウントとパスワードが一致しません。' を表示する。" do
      fill_in 'employees[password]', with: @user.password
      fill_in 'employees[account]', with: '間違ったパスワード'
      find('#submit_login').click

      expect(page).to have_selector '#flash_alert', text: 'アカウントとパスワードが一致しません。'
    end
  end

  describe '・アカウントとパスワードが一致した場合はメイン画面に遷移する。' do
    it 'is success!' do
      sign_in_as @user

      expect(current_path).to eq root_path
    end
  end
end
