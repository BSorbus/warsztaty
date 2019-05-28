class Exposition < ApplicationRecord

  # relations
  belongs_to :user
  has_many :works, as: :trackable

  has_one_attached :photo

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    uniqueness: { case_sensitive: false }



  validate :check_file_presence
  validate :check_file_size
  validate :check_file_type

  def fullname
    "#{name}"
  end

  def log_work(action = '', action_user_id = nil)
    #trackable_url = (action == 'destroy') ? nil : "#{url_helpers.role_path(self)}"
    trackable_url = (action == 'destroy') ? nil : "#{Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Exposition', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:user_id], include: {user: {only: [:id, :name, :email]}}))
  end

  private

  def check_file_presence
    errors.add(:photo, "nie może być puste") unless photo.attached?
  end

  def check_file_size
    if photo.attached?
      errors.add :photo, ' za duży (max 50 Mb)' if photo.blob.byte_size > 50.megabytes
    end
  end

  def check_file_type
    if photo.attached?
      errors.add :photo, ' może być tylko typu image/jpeg, image/png video/mp4' unless ['image/jpeg', 'image/png', 'video/mp4'].include? photo.blob.content_type 
    end
  end

end
