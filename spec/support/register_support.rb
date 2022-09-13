module RegisterSupport
  def register_employee_information
    fill_in 'employee[number]', with: '2'
    fill_in 'employee[last_name]', with: '太郎'
    fill_in 'employee[first_name]', with: '佐藤'
    fill_in 'employee[account]', with: 'satou'
    fill_in 'employee[password]', with: 'hogehoge'
    fill_in 'employee[email]', with: 'satou@aaa.com'
    select '2012', from: 'employee[date_of_joining(1i)]'
    select '4月', from: 'employee[date_of_joining(2i)]'
    select '1', from: 'employee[date_of_joining(3i)]'
    select '総務部', from: 'employee[department_id]'
    select '東京', from: 'employee[office_id]'
    check 'employee[employee_info_manage_auth]'
    check 'employee[news_posting_auth]'
    find('#submit_save').click
  end
end

RSpec.configure do |config|
  config.include RegisterSupport
end
