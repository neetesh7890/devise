class AlbumsController < ApplicationController
	
	before_action :get_friend_albums, only: [:friend_album, :index]
	
	#Actions
	def index	
		@albums = current_user.albums.ordered_desc.paginate(:page => params[:page], :per_page => 5)
		@friends_albums = @friend_albums.paginate(:page => params[:page], :per_page => 5)
	end

	def my_album
	end

	def friend_album
	end
	
	def my_album_all
		@album = current_user.albums.find(params[:id])
		@albumimage = AlbumImage.new
	end

	def destroy_pic
		@image = current_user.albums.find_by(id: params[:id]).album_images.find_by(id: params[:pic_id])	
		if @image.destroy
			redirect_to album_all_album_path(params[:id])
		else
			redirect_to album_all_album_path(params[:id])
		end
	end

	def show
	end

	def new
		@album = Album.new
		@album_image = @album.album_images.build
	end

	def create
		@album = current_user.albums.new(params.require(:album).permit(:album_name))
		images = params["album"]["image_name"]
		if images.present?
			images.each do |image|
				@album_image = @album.album_images.build
				@album_image.image_name = image
			 	@album_image.size = image.size
			end			
			if @album.save
				flash[:notice] = "Album Created"
				redirect_to albums_path	
			else
				flash[:notice] = "Album did not create size too large"
				render 'new'
			end
		else
			flash[:notice] = "Album could not uploaded please select atleat one image"
			redirect_to new_album_path	
		end
	end

	def edit
	end
	
	def update
		@album = current_user.albums.find_by(id: params[:id])
		img_names = params["album"]["image_name"] if @album.present?
		if img_names.present?
			img_names.each do |image|
				@album_image = @album.album_images.build
				@album_image.image_name = image		
			 	@album_image.size = image.size
			end
			if @album.save
				redirect_to album_all_album_path(params[:id])
			else
				flash[:notice] = "Album did update size too large"
				render 'my_album_all'
			end
		else
			flash[:notice] = "Album could not update"
			redirect_to album_all_album_path(params[:id])
		end
	end

	def destroy
		@album = current_user.albums.find_by(id: params[:id])
		if @album.destroy
			flash[:notice] = "Album deleted"
			redirect_to albums_path(current_user.id)
		else
			flash[:notice] = "Album could not deleted"
			redirect_to albums_path(current_user.id)
		end
	end

	def get_friend_albums
		user_ids = current_user.friends.confirm_friend.ids
		@friend_albums = Album.where(user_id: user_ids).ordered_desc
	end

	#Private methods
		private
			def album_params
	      params.require(:album).permit(:name,:album_name,:image_name)
	    end
end
