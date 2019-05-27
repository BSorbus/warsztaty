class Exposition < ApplicationRecord

  # relations
  belongs_to :user
  has_many :works, as: :trackable

  has_one_attached :photo

  # validates
  # validates :name, presence: true,
  #                   length: { in: 1..100 },
  #                   uniqueness: { case_sensitive: false }



  validate :check_file_presence

  def check_file_presence
    errors.add(:photo, "no file added") unless photo.attached?
  end


  def log_work(action = '', action_user_id = nil)
    #trackable_url = (action == 'destroy') ? nil : "#{url_helpers.role_path(self)}"
    trackable_url = (action == 'destroy') ? nil : "#{Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Exposition', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:user_id], include: {user: {only: [:id, :name, :email]}}))
  end

end
