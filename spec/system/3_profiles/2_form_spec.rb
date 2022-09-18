require 'rails_helper'

RSpec.describe '社員プロフィール（編集）', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    employee = create(:employee, department: department, office: office)
    sign_in_as employee
    visit new_employee_profile_path(employee)
  end

  describe '・プロフィールの入力ができる。' do
    it 'is success!' do
      expect do
        fill_in 'profile[profile]', with: '山田太郎です。'
        find('#submit_save').click
      end.to change(Profile, :count).by(1)
    end
  end

  describe '・保存ボタンをクリックしたとき、バリデーションチェックを行う。' do
    scenario "・プロフィール：300文字以内か？：'プロフィールは300文字以内で入力してください'" do
      fill_in 'profile[profile]',
              with: '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
              0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
              01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
      find('#submit_save').click

      expect(page).to have_selector '.profile_space ul li', text: 'プロフィールは300文字以内で入力してください'
    end
  end

  describe '・保存した後、一覧画面に遷移する。' do
    before do
      fill_in 'profile[profile]', with: '山田太郎です。'
      find('#submit_save').click
    end

    it 'is success!' do
      expect(current_path).to eq employees_path
    end
  end
end
