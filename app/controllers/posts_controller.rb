class PostsController < ApplicationController
  include ActionController::Live

  before_action :post, only: [:show, :update, :destroy]

  def index
    @posts = paginate(Post.includes(:user).order(created_at: :desc))
    render json: @posts
  end

  def by_user
    @posts = paginate(Post.includes(:user).where(user_id: params['user_id'])
                      .order(created_at: :desc))
    render json: @posts
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    head :no_content
  end

  private

  def post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :media, :content)
  end
end
