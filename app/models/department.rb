class Department < ApplicationRecord

  has_many :users
  has_many :works, as: :trackable

  validates :short, presence: true,
                    length: { in: 1..10 },
                    uniqueness: { case_sensitive: false }

  validates :name, presence: true,
                    length: { in: 1..100 },
                    uniqueness: { case_sensitive: false }


  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.user_path(self)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Department', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json())
  end

end
