class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      flash[:notice] = "friendship get!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship = Friendship.where(friend_id: current_user.id ,user_id: params[:id], status: "applying").first

    if @friendship.update(status: "friend")
      flash[:notice] = "Friend has been successfully added "
    else
      flash[:alert] = "Fail to add friend"
    end

    redirect_to friendships_path
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
