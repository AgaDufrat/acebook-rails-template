# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def search
    if params[:search]
      firstword = params[:search].split(' ').first
      lastword = params[:search].split(' ').last
      @results = User.where([
                              'lower(firstname) LIKE ?
                              OR lower(lastname) LIKE ?',
                              firstword.to_s.downcase,
                              lastword.to_s.downcase
                            ])
    end
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params['friend_id'])
    @opp_friendship = opposite_friendship(params['friend_id'], current_user.id)
    if @friendship.save && @opp_friendship.save
      flash[:notice] = 'Added friend.'
      redirect_to profile_page_path(current_user.id)
    else
      flash[:error] = 'Unable to add friend.'
      redirect_to friendships_search_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(
      friend_id: params['friend_id']
    )
    @opp_friendship = User.find(
      params['friend_id']
    ).friendships.find_by(friend_id: current_user.id)
    @friendship.destroy
    @opp_friendship.destroy
    flash[:notice] = 'Removed friendship.'
    redirect_to profile_page_path(current_user.id)
  end

  private

  def opposite_friendship(friend_id, current_user_id)
    User.find(friend_id).friendships.build(friend_id: current_user_id)
  end
end
