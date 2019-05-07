class Role < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  has_and_belongs_to_many :users
  has_many :works, as: :trackable

  # validates
  validates :name, presence: true,
                    length: { in: 1..100 },
                    uniqueness: { case_sensitive: false }

  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.role_path(self)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Role', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json())
  end


  def fullname
    "#{name}"
  end

  def name_as_link
    "<a href=#{url_helpers.role_path(self)}>#{self.name}</a>".html_safe
  end


  def role_link_add_remove(user, has_role)
    if has_role
      "<div style='text-align: center'><button ajax-path='#{url_helpers.role_user_path(role_id: self.id, id: user)}' ajax-method='DELETE' class='btn btn-xs btn-danger glyphicon glyphicon-minus'></button></div>".html_safe
    else
      "<div style='text-align: center'><button ajax-path='#{url_helpers.role_users_path(role_id: self.id, id: user)}' ajax-method='POST' class='btn btn-xs btn-success glyphicon glyphicon-plus'></button></div>".html_safe
    end
  end

end
