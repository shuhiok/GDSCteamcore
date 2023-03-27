class EventsController < ApplicationController

      def index
        @events = Event.all
      end

      def new
        @event = Event.new
      end
    
      def create
        event = Event.new(event_params)
        event.user_id = current_user.id 
        if event.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def show
        @event = Event.find(params[:id])
        @comments = @event.comments
        @comment = Comment.new
      end
    
      private
      def event_params
        params.require(:event).permit(:name, :community, :day, :about, :url, :user_id)
      end

end
