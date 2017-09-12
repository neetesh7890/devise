class CommentsController < ApplicationController
	
	#Filters skip
	skip_before_action :verify_authenticity_token, :only => [:remark]

	#Filters
	before_action :get_album, only: [:remark, :comments_remark,:index]	

	#Actions
	def index
		# @album = @user.albums.find_by(id: params[:album_id])
		@comment = Comment.new
		@friend = User.find_by(id: @album.user_id)
	end

	def remark
		@comment = @album.comments.build(comment_name: params[:new_comment], user_id: current_user.id)
		@comment.save
		respond_to do |format|
			format.js
		end
	end

	def destroy	
		@comment = Comment.find(params[:id])
		@comment = @comment.destroy
		respond_to do |format|
			format.js
		end
	end

	def album_comments
	end

	def new
	end

	def create
	end

	
	def show	
	end

	def edit 
	end

	def update
	end

	#Private methods
	private
		def get_album
			@album = Album.find_by(id: params[:album_id])
		end
end
