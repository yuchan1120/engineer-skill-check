require 'rails_helper'

RSpec.describe '社員プロフィール（参照）', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @employee = create(:employee, department: department, office: office)
    @profile = create(:profile, employee: @employee)
    sign_in_as @employee
    visit employee_profile_path(@employee, @profile)
  end

  describe '・社員情報の参照ができる。' do
    it 'is success!' do
      expect(page).to have_selector '#number', text: @employee.number
      expect(page).to have_selector '#name', text: "#{@employee.last_name} #{@employee.first_name}"
      expect(page).to have_selector '#department', text: @employee.department.name
      expect(page).to have_selector '#profile', text: @profile.profile
    end
  end

  describe '・一覧に戻るボタンをクリックしたときに、一覧画面へ遷移する。' do
    it 'is success!' do
      find('#link_employees_btn').click

      expect(current_path).to eq employees_path
    end
  end
end
