module ApplicationHelper

  def current_user_avatar
    current_user.avatar? ? current_user.avatar_url(:large).to_s : "images.png"
  end

  def first_image(item)
    item.album_images.first.present? ? item.album_images.first.image_name_url(:size_135_180) : "images.png"
  end
end
