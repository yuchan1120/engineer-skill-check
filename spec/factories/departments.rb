FactoryBot.define do
  factory :general_affairs, class: Department do
    id { '0' }
    name { '総務部' }
  end

  factory :engineering, class: Department do
    id { '1' }
    name { '技術部' }
  end
end
