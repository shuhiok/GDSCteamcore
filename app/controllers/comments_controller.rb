class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      event = Event.find(params[:event_id])
      comment = event.comments.build(comment_params) #buildを使い、contentとevent_idの二つを同時に代入
      comment.user_id = current_user.id
      if comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path) #直前のページにリダイレクト
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path) #直前のページにリダイレクト
      end
    end
  
    private
  
      def comment_params
        params.require(:comment).permit(:content)
      end
  end