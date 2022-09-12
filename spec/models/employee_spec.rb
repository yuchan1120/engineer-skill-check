require 'rails_helper'

RSpec.describe Employee, type: :model do
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
end
