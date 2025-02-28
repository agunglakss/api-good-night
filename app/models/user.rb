# frozen_string_literal: true

class User < ApplicationRecord
  has_many :sleep_trackings, dependent: :destroy

  has_many :active_friendships, class_name: "Friendship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_friendships, source: :followed

  has_many :passive_friendships, class_name: "Friendship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_friendships, source: :follower

  # check if already following a user
  def following?(user)
    following.include?(user)
  end

   # follow a user
   def follow(user)
    following << user unless following.include?(user)
  end
end
