class UserRolesDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:         { source: "Role.id", cond: :eq, searchable: false, orderable: false },
      name:       { source: "Role.name", cond: :like, searchable: true, orderable: true },
      activities: { source: "Role.activities", cond: :like, searchable: true, orderable: true },
      has_role:   { source: "Role.id",  searchable: false, orderable: false },
      action:     { source: "Role.id", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      user_has_role = User.joins(:roles).where(roles: {id: record.id}, users: {id: options[:only_for_current_user_id]}).any?
      {
        id:         record.id,
        name:       record.try(:name_as_link),
        activities: record.try(:activities),
        has_role:   user_has_role ? '<div style="text-align: center"><div class="glyphicon glyphicon-ok"></div></div>'.html_safe : '',
        action:     record.role_link_add_remove(options[:only_for_current_user_id], user_has_role)
      }
    end
  end

  private

  def get_raw_records
    Role.all
  end


  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

  # def filter_records(records)
  # end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
