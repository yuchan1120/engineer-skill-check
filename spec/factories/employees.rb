FactoryBot.define do
  factory :employee do
    number { '1' }
    last_name { '太郎' }
    first_name { '山田' }
    account { 'yamada' }
    password  { 'hogehoge' }
    email { 'yamada@aaa.com' }
    date_of_joining { '1991/4/1' }
    department_id { '0' }
    office_id { '0' }
    employee_info_manage_auth { 'TRUE' }
    news_posting_auth { 'TRUE' }
  end
end
