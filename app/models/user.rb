class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  def self.guest      #ゲストログイン機能
    find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end         

  has_one_attached :profile_image

  has_many :posts,    dependent: :destroy                #投稿
  has_many :comments, dependent: :destroy                #コメント
  has_many :likes,    dependent: :destroy                #いいね

  #フォロー中のユーザー
  has_many :active_relationships, class_name: 'RelationShip', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  #フォロワー
  has_many :passive_relationships, class_name: 'RelationShip', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  #送信したメッセージ
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy

  #受信したメッセージ
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy

end
