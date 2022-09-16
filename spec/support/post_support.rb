module PostSupport
  def create_post_and_visit_posts_path
    @post = create(:post, employee: @user)
    visit posts_path
  end

  def register_post
    fill_in 'post[title]', with: '総務部からのお知らせ'
    fill_in 'post[content]', with: '総務部からのお知らせです。'
    find('#submit_save').click
  end
end

RSpec.configure do |config|
  config.include PostSupport
end
