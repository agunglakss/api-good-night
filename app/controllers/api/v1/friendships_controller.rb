# frozen_string_literal: true
class Api::V1::FriendshipsController < ApplicationController
  include ApiResponse

  before_action :set_following
  before_action :user_and_followed_user_same
  before_action :already_followed, only: %w[follow]
  before_action :following?, only: %w[unfollow]

  def follow
    if @current_user.follow(@followed_user)
      render json: { message: 'Followed successfully' }, status: :ok
    else
      render json: { error: 'Already following this user' }, status: :unprocessable_entity
    end
  end

  def unfollow
    if @current_user.unfollow(@followed_user)
      render json: { message: 'Unfollowed successfully' }, status: :ok
    else
      render json: { error: 'Not following this user' }, status: :unprocessable_entity
    end
  end

  private

  def set_following
    @followed_user = User.find_by_id(params[:user_id])
    return error('user not found', :not_found) if @followed_user.nil?
  end

  def user_and_followed_user_same
    return error('id cannot be same', :unprocessable_entity) if @current_user.id == @followed_user.id
  end

  def already_followed
    return error('already following this user', :unprocessable_entity) if @current_user.following?(@followed_user)
  end

  def following?
    return error('this user is not following', :unprocessable_entity) unless @current_user.following?(@followed_user)
  end
end
