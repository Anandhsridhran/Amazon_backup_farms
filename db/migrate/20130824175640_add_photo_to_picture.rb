class AddPhotoToPicture < ActiveRecord::Migration
  def change
  	add_attachment :pictures, :photo
  end
end
