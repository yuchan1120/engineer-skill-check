require 'rails_helper'

RSpec.describe '社員情報登録', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    user = create(:employee, department: department, office: office)
    sign_in_as user
    visit new_employee_path
  end

  describe '・社員情報の登録ができる。' do
    it 'is success!' do
      expect { register_employee_information }.to change(Employee, :count).by(1)
    end
  end

  describe '・保存ボタンをクリックしたとき、バリデーションチェックを行う。' do
    before do
      find('#submit_save').click
    end

    scenario "・社員番号：入力されているか？：'社員番号が入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: '社員番号が入力されていません'
    end

    scenario "・氏名（姓）：入力されているか？：'氏名（姓）が入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: '氏名（姓）が入力されていません'
    end

    scenario "・氏名（名）：入力されているか？：'氏名（名）が入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: '氏名（名）が入力されていません'
    end

    scenario "・アカウント：入力されているか？：'アカウントが入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: 'アカウントが入力されていません'
    end

    scenario "・パスワード：入力されているか？：'パスワードが入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: 'パスワードが入力されていません'
    end

    scenario "・メールアドレス：入力されているか？：'メールアドレスが入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: 'メールアドレスが入力されていません'
    end

    scenario "・入社年月日：入力されているか？：'入社年月日が入力されていません'" do
      expect(page).to have_selector '.employee_form ul li', text: '入社年月日が入力されていません'
    end
  end

  describe '・登録した後、一覧画面に遷移する。' do
    before do
      register_employee_information
    end

    it 'is success!' do
      expect(current_path).to eq employees_path
    end
  end
end
