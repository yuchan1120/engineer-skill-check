module LoginSupport
  def sign_in_as(user)
    visit login_path
    fill_in 'employees[account]', with: user.account
    fill_in 'employees[password]', with: user.password
    find('#submit_login').click
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
