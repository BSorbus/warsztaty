class RoleDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:         { source: "Role.id", cond: :eq, searchable: false, orderable: false },
      name:       { source: "Role.name", cond: :like, searchable: true, orderable: true },
      note:       { source: "Role.note", cond: :like, searchable: true, orderable: true },
      activities: { source: "Role.activities", cond: :like, searchable: true, orderable: true }
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        name:       record.try(:name_as_link),
        #note:       truncate(Loofah.fragment(record.note).text, length: 50),
        note:       record.note,
        activities: record.try(:activities)
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
