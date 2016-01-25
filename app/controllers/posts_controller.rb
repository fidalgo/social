class PostsController < ApplicationController
  include ActionController::Live

  before_action :post, only: [:show, :update, :destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc).find_in_batches
    stream_json_from_enumeration(@posts)
  end

  def by_user
    @posts = Post.includes(:user).where(user_id: params['user_id']).order(created_at: :desc)
    stream_json_from_enumeration(@posts)
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

  def stream_json_from_enumeration(enumeration)
    response.headers['Content-Type'] = 'application/json'

    buffer = "[\n  "
    counter = 0
    enumeration.each do |object|
      if object.respond_to?(:each)
        object.each do |element|
          buffer << ",\n  " unless counter == 0
          buffer << element.to_json
          counter += 1
        end
      else
        buffer << ",\n  " unless counter == 0
        buffer << object.to_json
        counter += 1
      end

      if counter % enumeration.size == 0
        response.stream.write buffer
        buffer = ''
      end
    end
    buffer << "\n]\n"
    response.stream.write buffer
  ensure
    response.stream.close
  end
end
