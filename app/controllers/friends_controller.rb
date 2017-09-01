class FriendsController < ApplicationController
	
	#Filters skip
	# skip_before_action :access_check, only: [:notification,:accept,:show,:search,:destroy]

	before_action :get_friends, only: [:index,:show,:search]

	#Actions
	def index
		# @friends = current_user.friends.confirm_friend
	end

	def show
		# @friends = current_user.friends.confirm_friend
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
			redirect_to user_dashboards_path(current_user.id)
		else
			redirect_to user_dashboards_path(current_user.id)
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
			redirect_to user_dashboards_path(current_user.id) and return
		end
		redirect_to user_dashboards_path(current_user.id)
		# if current_userfriend.token == params["token"] && session[:user_id]==current_userfriend.friend_id
		# 	debugger
		# 	mutual =  current_user.user_friends.build(token: current_userfriend.token,friend_id: current_userfriend.user_id, status: "accept")
		# 	if mutual.save
		# 		flash[:notice] = "Friend Added"
		# 	else
		# 		flash[:notice] = "Could not added"
		# 	end
		# end

		# if current_userfriend.status == "accept"
		# 		flash[:notice] = "Already added"
		# 		redirect_to user_dashboards_path(user_id: current_user.id)
		# else
		# 	if current_userfriend.token == params["token"] && session[:user_id]==current_userfriend.friend_id
		# 		current_userfriend.status = "accept"
		# 		if  current_userfriend.save
		# 			flash[:notice] = "Friend added"	
		# 			redirect_to user_dashboards_path(user_id: current_user.id)
		# 		end
		# 	else
		# 		flash[:notice] = "Invalid Link"
		# 		redirect_to user_dashboards_path(user_id: current_user.id)
		# 	end
		# end
	end

	def destroy
		friend = UserFriend.find_by("friend_id = ? AND user_id = ?",params[:id],params[:user_id])
		# friend_entries = current_user.user_friends.where("friend_id = ?",params[:id])
		friend_entries = UserFriend.where(token: friend.token)
		friend_entries.destroy_all if friend_entries.present?
		redirect_to user_friends_path(current_user.id) 
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
