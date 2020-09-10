class Friendship < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :inverse_friend, class_name: 'User'
  validates :friend, uniqueness: { scope: :inverse_friend }

  def confirm_friendship
    update_attributes(status: 'confirmed')
    Friendship.create!(friend: inverse_friend, inverse_friend: friend, status: 'confirmed')
  end
end
