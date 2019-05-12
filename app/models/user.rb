class User < ApplicationRecord
  include ActionView::Helpers::UrlHelper # for link_to
  include ActionView::Helpers::AssetTagHelper # for image_tag
  delegate :url_helpers, to: 'Rails.application.routes'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :confirmable, 
         :recoverable,
         :registerable,
         :timeoutable, 
         :trackable, 
         :validatable,
         :lockable,
         :password_expirable,
         :secure_validatable, 
         :password_archivable, 
         :expirable

  # devise  :database_authenticatable, 
  #         :recoverable, 
  #         :registerable, 
  #         :timeoutable, 
  #         :trackable, 
  #         :validatable,
  #         :lockable,
  #           :password_expirable,
  #           :secure_validatable, 
  #           :password_archivable, 
  #           :expirable,
  #         :authentication_keys => [:email]

  # relations
  has_and_belongs_to_many :roles
  belongs_to :department
  has_many :surveys
  has_many :works, as: :trackable

  has_one_attached :photo

  validate :password_complexity

  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.user_path(self)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'User', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:department_id], include: {department: {only: [:id, :short, :name]}}))
  end

  def password_complexity
    #if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\W])/)
    if password.present? and not password.match(/(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*(_|[\W]))/)
      errors.add :password, "Hasło musi zawierać małą literę, wielką literę, liczbę i symbol"
    end
  end

  # callbacks
  before_destroy :has_important_links, prepend: true

  def has_important_links
    analize_value = true
    # if self.accessorizations.any? 
    #  errors.add(:base, 'Nie można usunąć konta "' + self.try(:fullname) + '" które jest powiązane z Zadaniami.')
    #  analize_value = false
    # end
    # throw :abort unless analize_value 
  end

  def fullname
    "#{name} (#{email})"
  end

  def name_as_link
    # puts '========================================'
    # #puts link_to "#{self.name}", "#{url_helpers.user_path(self)}"
    # puts self.photo.previewable?
    # puts self.photo.variable?
    # puts image_tag(Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true)), "#{url_helpers.user_path(self)}"
    # puts '========================================'

    link_to image_tag(Rails.application.routes.url_helpers.rails_blob_path(self.photo, only_path: true), width: "50") + "  #{self.name}", "#{url_helpers.user_path(self)}"


    #link_to "#{self.name}", "#{url_helpers.user_path(self)}"
    # "<a href=#{url_helpers.user_path(self)}>#{self.name}</a>".html_safe
  end

  def photo_link
    if self.photo.attached?
      link_to(image_tag(self.photo.variant(resize: "100x100")), url_helpers.user_path(self)).html_safe 
    else
      ""
    end
    #link_to(self.name, url_helpers.user_path(self)).html_safe
  end

  def surveys_any
    self.surveys.any? ? '<div style="text-align: center"><div class="glyphicon glyphicon-ok"></div></div>'.html_safe : ''
  end

  def user_link_add_remove(role, has_user)
    if has_user
      "<div style='text-align: center'><button ajax-path='#{url_helpers.role_user_path(role_id: role, id: self.id)}' ajax-method='DELETE' class='btn btn-xs btn-danger glyphicon glyphicon-minus'></button></div>".html_safe
    else
      "<div style='text-align: center'><button ajax-path='#{url_helpers.role_users_path(role_id: role, id: self.id)}' ajax-method='POST' class='btn btn-xs btn-success glyphicon glyphicon-plus'></button></div>".html_safe
    end
 end



  # Scope for select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Jan ski@"
  # * result   :
  #   * +scope+ -> collection 
  #
  scope :finder_user, ->(q) { where( create_sql_string("#{q}") ) }

  # Method create SQL query string for finder select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Jan ski@"
  # * result   :
  #   * +sql_string+ -> string for SQL WHERE... 
  #   Eg.: "((users.name ilike '%Jan%' OR users.email ilike '%Jan%') AND (users.name ilike '%ski@%' OR users.email ilike '%ski@%'))"
  #
  def self.create_sql_string(query_str)
    query_str.split.map { |par| one_param_sql(par) }.join(" AND ")
  end

  # Method for glue parameters in create_sql_string
  # * parameters   :
  #   * +one_query_word+ -> word for search. 
  #   Eg.: "Jan"
  # * result   :
  #   * +sql_string+ -> SQL string query for one word 
  #   Eg.: "(users.name ilike '%Jan%' OR users.email ilike '%Jan%')"
  #
  def self.one_param_sql(one_query_word)
    #escaped_query_str = sanitize("%#{query_str}%")
    escaped_query_str = Loofah.fragment("'%#{one_query_word}%'").text
    "(" + %w(users.name users.email).map { |column| "#{column} ilike #{escaped_query_str}" }.join(" OR ") + ")"
  end

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  

  # # Integration with ActiveJob
  # def send_devise_notification(notification, *args)
  #   devise_mailer.send(notification, self, *args).deliver_later
  # end

  # Override Devise::Confirmable#after_confirmation
  def after_confirmation
    super
    Work.create( trackable_id: self.id, trackable_type: 'User', trackable_url: "#{Rails.application.routes.url_helpers.user_path(self)}", action: 'account_confirmation', user_id: self.id, 
      parameters: {id: self.id, name: self.name, email: self.email}.to_json )
  end

  # this gets called every time a request fails due to lacking authentication
  Warden::Manager.before_failure do |env, opts|
    # parse params
    # Rack::Request.new(env).params

    # authentication failed:
    # opts == {:scope=>:user, :recall=>"devise/sessions#new", :action=>"unauthenticated", :attempted_path=>"/users/sign_in"}

    # redirect as a user is required
    # opts == {:scope=>:user, :action=>"unauthenticated", :attempted_path=>"/"}
    # 'trigger sign in failed' if opts.has_key?(:recall)

      my_hash = opts
      my_hash[:REMOTE_ADDR] = env["REMOTE_ADDR"]
      my_hash[:REQUEST_URI] = env["REQUEST_URI"]
      #my_hash["rack.session"] = env["rack.session"] # za dużo danych

      # usuwa "password" z hasha
      my_hash["rack.request.form_hash"] = Hash[env["rack.request.form_hash"].map {|k,v| [k,(v.respond_to?(:except)?v.except("password"):v)] }] if env["rack.request.form_hash"].present?
      # get a flash notice! 
      my_hash["flash"] = deep_find(:flash, env["rack.session"], found=nil) 

      Work.create( action: 'unauthenticated', user_id: nil, parameters: my_hash.to_json ) if opts.has_key?(:recall)
  end


  #Warden::Manager.after_failed_fetch do |user, auth, opts|
  #  #your custom code
  #    puts "##########################################################"
  #    puts "# Warden::Manager.after_failed_fetch "
  #    puts user
  #    puts auth
  #    puts opts
  #    puts "##########################################################"
  #  #'trigger user request'
  #end


  def self.deep_find(key, object=self, found=nil)
    if object.respond_to?(:key?) && object.key?(key)
      return object[key]
    elsif object.is_a? Enumerable
      object.find { |*a| found = deep_find(key, a.last) }
      return found
    end
  end


end
