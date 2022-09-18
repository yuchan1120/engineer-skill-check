require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @employee = create(:employee, department: department, office: office)
  end

  it 'is valid with an employee and 1 character or more profile' do
    profile = Profile.new(
      profile: 'よろしくお願いします。',
      employee: @employee
    )
    expect(profile).to be_valid
  end

  it 'is invalid if profile is less than 1 character' do
    profile = Profile.new(profile: '')
    profile.valid?
    expect(profile.errors).to be_of_kind(:profile, :too_short)
  end

  it 'is invalid if profile exceeds 300 characters' do
    profile = Profile.new(
      profile: '0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
      0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
      01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
    )
    profile.valid?
    expect(profile.errors).to be_of_kind(:profile, :too_long)
  end
end
