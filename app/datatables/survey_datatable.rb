class SurveyDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id:         { source: "Survey.id" },
      user:       { source: "User.name" },
      created_at: { source: "Survey.created_at" },
      updated_at: { source: "Survey.updated_at" },
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        user:       record.number_as_link,
        created_at: record.created_at.strftime("%Y-%m-%d %H:%M:%S"),
        updated_at: record.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      }
    end
  end

  def get_raw_records
    # insert query here
    Survey.joins(:user).all
  end

end

