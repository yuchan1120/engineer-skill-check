module PostSupport
  def create_post_and_visit_posts_path
    @post = create(:post, employee: @user)
    visit posts_path
  end
end

RSpec.configure do |config|
  config.include PostSupport
end
