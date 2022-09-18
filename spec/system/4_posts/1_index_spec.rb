require 'rails_helper'

RSpec.describe 'お知らせ一覧', type: :system do
  before do
    department = create(:general_affairs)
    office = create(:tokyo)
    @user = create(:employee, department: department, office: office)
    @another_user = create(:another_user, department: department, office: office)
    sign_in_as @user
  end

  describe '・メニューのお知らせをクリックしたとき、お知らせの一覧画面に遷移する。' do
    it 'is success!' do
      visit employees_path
      find('#link_posts_header').click

      expect(current_path).to eq posts_path
    end

    scenario '・一覧には、タイトル、公開日を表示する。' do
      create_post_and_visit_posts_path

      expect(page).to have_selector '.title', text: @post.title
      expect(page).to have_selector '.created_at', text: @post.created_at.to_s(:datetime_jp)
    end

    scenario '・公開日でソート（昇順／降順）ができる。デフォルトは公開日の降順で表示する。' do
      post_before = create(:post, title: '8月のお知らせ', employee: @user)
      post_after = create(:post, title: '9月のお知らせ', employee: @user)
      visit posts_path

      expect(page).to have_selector '#post-0th-title', text: post_before.title
      expect(page).to have_selector '#post-1th-title', text: post_after.title

      find('#sort_created_at a').click

      expect(page).to have_selector '#post-0th-title', text: post_after.title
      expect(page).to have_selector '#post-1th-title', text: post_before.title
    end
  end

  describe '・ログインユーザがお知らせ投稿権限を持っている場合、新規追加ボタン／編集ボタン／削除ボタンを表示する。' do
    it 'is success!' do
      create_post_and_visit_posts_path

      expect(page).to have_selector '#link_new_post'
      expect(page).to have_selector '#link_edit_post_0th'
      expect(page).to have_selector '#link_delete_post_0th'
    end

    scenario '・お知らせの記事は自分が投稿した記事のみ編集／削除ができる。' do
      create(:post, employee: @user)
      create(:post, employee: @another_user)
      visit posts_path

      expect(page).to have_selector '#link_edit_post_0th'
      expect(page).to have_selector '#link_delete_post_0th'
      expect(page).to_not have_selector '#link_edit_post_1th'
      expect(page).to_not have_selector '#link_delete_post_1th'
    end
  end

  describe '・新規登録ボタンをクリックしたとき、お知らせ登録画面に遷移する。' do
    it 'is success!' do
      visit posts_path
      find('#link_new_post').click

      expect(current_path).to eq new_post_path
    end
  end

  describe '・編集ボタンをクリックしたとき、お知らせ登録画面に遷移する。' do
    it 'is success!' do
      create_post_and_visit_posts_path
      find('#link_edit_post_0th').click

      expect(current_path).to eq edit_post_path(@post)
    end
  end

  describe '・削除ボタンをクリックしたとき、削除の確認ダイアログを表示して、お知らせの削除ができる。' do
    pending('is pending. (Docker環境にchrome未導入のため)')
    # it 'is success!', js: true do
    #   create_post_and_visit_posts_path
    #   find('#link_delete_post_0th').click

    #   expect{
    #     expect(page.accept_confirm).to eq "お知らせ「#{@post.title}」を削除します。よろしいですか？"
    #     expect(page).to have_content "お知らせ「#{@post.title}」を削除しました。"
    #     }. to change(Post.active, :count).by(-1)
    # end
  end

  describe '・タイトルをクリックしたとき、お知らせ参照画面に遷移する。' do
    it 'is success!' do
      create_post_and_visit_posts_path
      find('#post-0th-title a').click

      expect(current_path).to eq post_path(@post)
    end
  end
end
