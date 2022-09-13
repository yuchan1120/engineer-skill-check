require 'rails_helper'

RSpec.describe Employee, type: :model do
  before do
    @department = create(:general_affairs)
    @office = create(:tokyo)
  end

  it 'is valid with a number, last_name, first_name, account, password, email, date_of_joining, department, and office' do
    employee = Employee.new(
      number: '1',
      last_name: '山田',
      first_name: '太郎',
      account: 'yamada',
      password: 'hogehoge',
      email: 'yamada@example.co.jp',
      date_of_joining: '1991/4/1',
      department: @department,
      office: @office
    )
    expect(employee).to be_valid
  end

  it 'is invalid without a number' do
    employee = Employee.new(number: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:number, :blank)
  end

  it 'is invalid without a last_name' do
    employee = Employee.new(last_name: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:last_name, :blank)
  end

  it 'is invalid without a first_name' do
    employee = Employee.new(first_name: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:first_name, :blank)
  end

  it 'is invalid without an account' do
    employee = Employee.new(account: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:account, :blank)
  end

  it 'is invalid without a password' do
    employee = Employee.new(password: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:password, :blank)
  end

  it 'is invalid without an email' do
    employee = Employee.new(email: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:email, :blank)
  end

  it 'is invalid without a date_of_joining' do
    employee = Employee.new(date_of_joining: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:date_of_joining, :blank)
  end

  it 'is invalid without a department' do
    employee = Employee.new(department: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:department, :blank)
  end

  it 'is invalid without an office' do
    employee = Employee.new(office: nil)
    employee.valid?
    expect(employee.errors).to be_of_kind(:office, :blank)
  end
end
