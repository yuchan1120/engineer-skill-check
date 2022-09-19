require 'rails_helper'

RSpec.describe '社員紹介一覧', type: :system do
  before do
    @department = create(:general_affairs)
    @another_department = create(:engineering)
    @office = create(:tokyo)
  end

  describe '・メニューの社員紹介をクリックしたとき、社員一覧画面に遷移する。' do
    it 'is success!' do
      create_employee_and_sign_in_as_employee
      visit posts_path
      find('#link_employees_header').click

      expect(current_path).to eq employees_path
    end

    scenario '・一覧には、社員番号、氏名、所属を表示する。' do
      create_employee_and_sign_in_as_employee

      expect(page).to have_selector '#employee-0th-number', text: @employee.number
      expect(page).to have_selector '#employee-0th-name', text: "#{@employee.last_name} #{@employee.first_name}"
      expect(page).to have_selector '#employee-0th-department', text: @employee.department.name
    end

    scenario '・社員番号、所属でソート（昇順／降順）ができる。デフォルトは社員番号の昇順で表示する。' do
      employee_number1 = create(:employee, number: 1, department: @department, office: @office)
      employee_number2 = create(:another_user, number: 2, department: @another_department, office: @office)
      sign_in_as employee_number1

      # デフォルトは社員番号の昇順で表示する。
      expect(page).to have_selector '#employee-0th-name',
                                    text: "#{employee_number1.last_name} #{employee_number1.first_name}"
      expect(page).to have_selector '#employee-1th-name',
                                    text: "#{employee_number2.last_name} #{employee_number2.first_name}"

      # 社員番号でソート（昇順／降順）ができる。
      find('#sort_number a').click

      expect(page).to have_selector '#employee-0th-name',
                                    text: "#{employee_number2.last_name} #{employee_number2.first_name}"
      expect(page).to have_selector '#employee-1th-name',
                                    text: "#{employee_number1.last_name} #{employee_number1.first_name}"

      find('#sort_number a').click

      expect(page).to have_selector '#employee-0th-name',
                                    text: "#{employee_number1.last_name} #{employee_number1.first_name}"
      expect(page).to have_selector '#employee-1th-name',
                                    text: "#{employee_number2.last_name} #{employee_number2.first_name}"

      # 所属でソート（昇順／降順）ができる。
      find('#sort_department_id a').click

      expect(page).to have_selector '#employee-0th-name',
                                    text: "#{employee_number2.last_name} #{employee_number2.first_name}"
      expect(page).to have_selector '#employee-1th-name',
                                    text: "#{employee_number1.last_name} #{employee_number1.first_name}"

      find('#sort_department_id a').click

      expect(page).to have_selector '#employee-0th-name',
                                    text: "#{employee_number1.last_name} #{employee_number1.first_name}"
      expect(page).to have_selector '#employee-1th-name',
                                    text: "#{employee_number2.last_name} #{employee_number2.first_name}"
    end
  end

  describe '・ログインユーザが社員情報管理権限を持っている場合、新規追加ボタン／編集ボタン／削除ボタンを表示する。' do
    it 'is success!' do
      create_employee_and_sign_in_as_employee

      expect(page).to have_selector '#link_new_employee'
      expect(page).to have_selector '#link_edit_employee_0th'
      expect(page).to have_selector '#link_delete_employee_0th'
    end
  end

  describe '・新規追加ボタンをクリックしたとき、社員情報登録画面に遷移する。' do
    it 'is success!' do
      create_employee_and_sign_in_as_employee
      find('#link_new_employee').click

      expect(current_path).to eq new_employee_path
    end
  end

  describe '・編集ボタンをクリックしたとき、社員情報登録画面に遷移する。' do
    it 'is success!' do
      create_employee_and_sign_in_as_employee
      find('#link_edit_employee_0th').click

      expect(current_path).to eq edit_employee_path(@employee)
    end
  end

  describe '・削除ボタンをクリックしたとき、削除の確認ダイアログを表示して、社員情報の削除ができる。' do
    it 'is pending.' do
      pending('Docker環境にchrome未導入のため')
      create_employee_and_sign_in_as_employee
      find('#link_delete_employee_0th').click

      expect do
        expect(page.accept_confirm).to eq "社員「#{employee.first_name} #{employee.last_name}」を削除します。よろしいですか？"
        expect(page).to have_content "社員「#{@employee.last_name} #{@employee.first_name}」を削除しました。"
      end.to change(Employee.active, :count).by(-1)
    end
  end

  describe '・社員番号をクリックしたとき、社員プロフィール画面に遷移する。' do
    before do
      @employee = create(:employee, department: @department, office: @office)
      @another_employee = create(:another_user, department: @department, office: @office)
      @profile = create(:profile, employee: @employee)
      @another_profile = create(:profile, employee: @another_employee)
      sign_in_as @employee
    end

    scenario '・自分のプロフィールの場合、社員プロフィール（編集）に遷移する。' do
      find('#employee-0th-number a').click

      expect(current_path).to eq edit_employee_profile_path(@employee, @profile)
    end

    scenario '・他人のプロフィールの場合、社員プロフィール（参照）に遷移する。' do
      find('#employee-1th-number a').click

      expect(current_path).to eq employee_profile_path(@another_employee, @another_profile)
    end
  end
end
