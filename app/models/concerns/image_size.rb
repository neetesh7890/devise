module ImageSize
  def avatar_size
    errors.add(:base, "Image should be less than 5MB") if size > 5.megabytes
  end 
end