class RoleUsersDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:         { source: "User.id", cond: :eq, searchable: false, orderable: false },
      name:       { source: "User.name", cond: :like, searchable: true, orderable: true },
      note:       { source: "User.note", cond: :like, searchable: true, orderable: true },
      has_role:   { source: "User.id",  searchable: false, orderable: false },
      action:     { source: "User.id", searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      role_has_user = Role.joins(:users).where(users: {id: record.id}, roles: {id: options[:only_for_current_role_id]}).any?
      {
        id:         record.id,
        name:       record.try(:name_as_link),
        note:       record.note,
        has_role:   role_has_user ? '<div style="text-align: center"><div class="glyphicon glyphicon-ok"></div></div>'.html_safe : '',
        action:     record.user_link_add_remove(options[:only_for_current_role_id], role_has_user)
      }
    end
  end

  private

  def get_raw_records
    User.all
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
