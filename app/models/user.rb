class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  mount_uploader :avatar, AvatarUploader


  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  # 「使用者喜歡很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 一個user，可以有很多提交的交友紀錄（紀錄在friendships table）
  has_many :friendships, dependent: :destroy
  # 一個user，可透過已提交的多筆交友紀錄，得知有多少user是自己的朋友
  has_many :friends, through: :friendships

   # 一個user，可以有很多筆被加為好友的交友紀錄（紀錄在friendships table）
   has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
   # 一個user，可以透過多筆被加為好友的交友紀錄，得知哪些user向自己提出交友(all_friends)
   has_many :all_friends, through: :inverse_friendships, source: :user

  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
     self.friends.include?(user)
   end

end
