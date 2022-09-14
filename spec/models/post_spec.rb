require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @employee = create(:employee, department: department, office: office)
  end

  it 'is valid with a title and employee' do
    post = Post.new(
      title: '総務部からのお知らせ',
      employee: @employee
    )
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors).to be_of_kind(:title, :blank)
  end

  it 'is invalid if title exceeds 50 characters' do
    post = Post.new(title: '012345678901234567890123456789012345678901234567890')
    post.valid?
    expect(post.errors).to be_of_kind(:title, :too_long)
  end
end
