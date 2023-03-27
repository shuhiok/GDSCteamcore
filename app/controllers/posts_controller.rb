class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def kanryo
      @posts = Post.all
    end

    def index
        @posts = Post.all
        @tag_list = Tag.all  
    end

    def new
        @post = Post.new
        @post = current_user.posts.new 
    end

    def show
        @post = Post.find(params[:id])
        @post_tags = @post.tags
    end

    def edit
        @post = Post.find(params[:id])
        @tag_list=@post.tags.pluck(:tag_name).join(nil)
    end

    def create
      @post = current_user.posts.new(post_params)           
      tag_list = params[:post][:tag_name].split(nil) 

      if @post.save
         @post.save_tag(tag_list)                                                           
         redirect_to posts_path      
      else
         redirect_to new_post_path         
      end
   end

    def update
      post = Post.find(params[:id])
      tag_list = params[:post][:tag_name].split(nil)

      if post.update(post_params)
        old_relations = TagMap.where(post_id: post.id)
        old_relations.each do |relation|
          relation.delete
        end
        post.save_tag(tag_list)
        redirect_to post_path(post.id), notice:'投稿完了しました:)'
      else
        redirect_to :action => "edit"
      end
    end

    def destroy
      post = Post.find(params[:id])
      post.destroy
      redirect_to action: :index
    end

    def search
      @tag_list = Tag.all               # こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
      @tag = Tag.find(params[:tag_id])  # クリックしたタグを取得
      @posts = @tag.posts.all           # クリックしたタグに紐付けられた投稿を全て表示
    end
    
      private
      def post_params
        params.require(:post).permit(:url, :name, :kikan, :kigen, :syuryo, :mail, :about)
      end
end
