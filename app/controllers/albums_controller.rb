class AlbumsController < ApplicationController
	
	#Actions
	def index	
		@albums = current_user.albums.albums_order_by_comments.paginate(:page => params[:page], :per_page => 5)
		user_ids = current_user.friends.confirm_friend.ids
		@friends_albums = Album.where(user_id: user_ids).albums_order_by_comments.paginate(:page => params[:page], :per_page => 5)
	end

	def my_album
	end

	def friend_album
		user_ids = current_user.friends.confirm_friend.pluck(:id)
		@friend_albums = Album.where(user_id: user_ids).albums_order_by_comments
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

		# img_names = params["album"]["image_name"]
		# if img_names.present?
			# img_names.each do |img_name|
			# 	@albumimage = @album.album_images.new
			# 	pic_name = img_name.original_filename
			# 	File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		 #      file.write(img_name.read)
		 #        @albumimage.image_name = pic_name
		 #      end
			# end

			# if @album.save
		# 		flash[:notice] = "Album Created"
		# 		redirect_to user_albums_path(current_user.id)	
		# 	else
		# 		redirect_to user_albums_path(current_user.id)		
		# 	end
		# else
		# 	flash[:notice] = "Album could not be created please select atleast one image"
		# 	redirect_to user_albums_path(current_user.id)		
		# end
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
		# unless img_names.nil?
		# 	img_names.each do |img_name|
		# 		@albumimage = AlbumImage.new
		# 		@albumimage.album_id = @album.id
		# 		pic_name = img_name.original_filename
		# 		File.open(Rails.root.join('public', 'uploads', pic_name), 'wb') do |file|
		#       file.write(img_name.read)
		# 		@albumimage.image_name = pic_name
		#     end
		# 		redirect_to album_all_user_album_path(current_user.id,params[:id]) and return unless @albumimage.save	 #true par nahi chalega false par redirect to		        
		# 		flash[:notice] = "Album Updated"
		# 	end
		# end
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

	#Private methods
	private
		def album_params
      params.require(:album).permit(:name,:album_name,:image_name)
    end
end
