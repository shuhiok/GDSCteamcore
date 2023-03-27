class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy 
         validates :name, presence: true
         validates :profile, length: { maximum: 200 } 
         
         has_many :comments, dependent: :destroy
         has_many :events
         has_many :likes, dependent: :destroy
         has_many :liked_events, through: :likes, source: :event

         def already_liked?(event)
          self.likes.exists?(event_id: event.id)
        end
end
