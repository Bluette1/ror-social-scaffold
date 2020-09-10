class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  has_many :requested_friendships,
           -> { where status: 'pending' }, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :requested_friends, through: :requested_friendships, source: :inverse_friend, dependent: :destroy

  has_many :requesting_friendships,
           -> { where status: 'pending' },
           class_name: 'Friendship',
           foreign_key: 'inverse_friend_id',
           dependent: :destroy
  has_many :requesting_friends, through: :requesting_friendships, source: :friend, dependent: :destroy

  has_many :confirmed_friendships,
           -> { where status: 'confirmed' }, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :friends, through: :confirmed_friendships, source: :inverse_friend, dependent: :destroy

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
