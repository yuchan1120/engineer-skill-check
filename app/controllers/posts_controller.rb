class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :post_owner?, only: %i[edit update destroy]

  def index
    @posts = Post.active.order("#{sort_column} #{sort_direction}")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(employee_id: current_user.id)

    if @post.update(post_params)
      redirect_to posts_url, notice: "お知らせ「#{@post.title}」を登録しました。"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_url, notice: "お知らせ「#{@post.title}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      now = Time.zone.now
      @post.update_column(:deleted_at, now)
    end

    redirect_to posts_url, notice: "お知らせ「#{@post.title}」を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params['id'])
  end

  def sort_column
    params[:sort] || 'created_at'
  end

  def sort_direction
    params[:direction] || 'asc'
  end

  def post_owner?
    @post = Post.find(params['id'])
    redirect_to posts_path unless @post.employee == current_user
  end
end
