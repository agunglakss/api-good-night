# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
  
  validates :follower_id, uniqueness: { scope: :followed_id, message: "Already following this user" }
end
