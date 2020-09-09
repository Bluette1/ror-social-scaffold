class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'inverse_friend_id'

  has_many :requested_friendships, -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :requested_friends, through: :requested_friendships, source: :inverse_friend

  has_many :requesting_friendships,
           -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'inverse_friend_id'
  has_many :requesting_friends, through: :requesting_friendships, source: :friend

  def friends
    friends = friendships.map { |friendship| friendship.inverse_friend if friendship.status == 'confirmed' }
    inverse_friends = inverse_friendships.map { |friendship| friendship.friend if friendship.status == 'confirmed' }

    (friends + inverse_friends).compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending?(user)
    request_to?(user) || request_from?(user) ? true : false
  end

  def friends_and_own_posts
    Post.where(user: (friends + [self]))
  end

  def request_to?(user)
    requested_friends.include?(user)
  end

  def request_from?(user)
    requesting_friends.include?(user)
  end
end
