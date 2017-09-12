class FriendsController < ApplicationController
	
	#Filters 
	before_action :get_friends, only: [:index,:show,:search]

	#Actions
	def index
	end

	def show
	end

	def search
		ids = @friends.ids
		ids = ids.push(current_user.id)
		@results = User.search(params[:q]).all_friends(ids)
	end

	def notification
		@friend = User.find_by(id: params["friend_id"])
		@token = SecureRandom.uuid.gsub(/\-/,'')
		UserMailer.notification(current_user, @friend, @token).deliver_later
		current_userfriend = current_user.user_friends.build(friend_id: @friend.id,token: @token,status: "pending")
		if current_userfriend.save
			redirect_to dashboards_path
		else
			redirect_to dashboards_path
		end
	end

	def new
	end
	
	def accept
		current_userfriend = UserFriend.find_by(token: params["token"])
		if current_userfriend.status == "accept"
			flash[:notice] = "Already added"
		elsif current_userfriend.token == params["token"] && current_user.id == current_userfriend.friend_id
			mutual =  current_user.user_friends.build(token: current_userfriend.token,friend_id: current_userfriend.user_id, status: "accept")
			current_userfriend.status = "accept"
			flash[:notice] = mutual.save && current_userfriend.save ? "Friend Added" : "Could not added"
		else
			flash[:notice] = "Invalid Link"
			redirect_to dashboards_path and return
		end
		redirect_to dashboards_path
	end

	def destroy
		friend = UserFriend.find_by("friend_id = ? AND user_id = ?",params[:id],current_user.id)
		friend_entries = UserFriend.where(token: friend.token)
		friend_entries.destroy_all if friend_entries.present?
		redirect_to friends_path
	end

	def edit
	end

	def update
	end

	private
		def get_friends
			@friends = current_user.friends.confirm_friend
		end
end
