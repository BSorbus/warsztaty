class Survey < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  belongs_to :user
  has_many :works, as: :trackable

  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.role_path(self)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Survey', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:user_id], include: {user: {only: [:id, :name, :email]}}))
  end

  def number_as_link
    "<a href=#{url_helpers.survey_path(self)}>#{self.user.name}</a>".html_safe
  end

end
