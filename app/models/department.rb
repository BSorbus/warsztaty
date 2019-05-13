class Department < ApplicationRecord

  has_many :users
  has_many :works, as: :trackable

  has_many :answer_1_place_1_surveys, foreign_key: :answer_1_place_1, class_name: "Survey"
  has_many :answer_1_place_2_surveys, foreign_key: :answer_1_place_2, class_name: "Survey"
  has_many :answer_1_place_3_surveys, foreign_key: :answer_1_place_3, class_name: "Survey"

  has_many :answer_2_place_1_surveys, foreign_key: :answer_2_place_1, class_name: "Survey"
  has_many :answer_2_place_2_surveys, foreign_key: :answer_2_place_2, class_name: "Survey"
  has_many :answer_2_place_3_surveys, foreign_key: :answer_2_place_3, class_name: "Survey"

  has_many :answer_3_place_1_surveys, foreign_key: :answer_3_place_1, class_name: "Survey"
  has_many :answer_3_place_2_surveys, foreign_key: :answer_3_place_2, class_name: "Survey"
  has_many :answer_3_place_3_surveys, foreign_key: :answer_3_place_3, class_name: "Survey"

  has_many :answer_4_place_1_surveys, foreign_key: :answer_4_place_1, class_name: "Survey"
  has_many :answer_4_place_2_surveys, foreign_key: :answer_4_place_2, class_name: "Survey"
  has_many :answer_4_place_3_surveys, foreign_key: :answer_4_place_3, class_name: "Survey"


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

  def answer_place_1_surveys
    self.answer_1_place_1_surveys + self.answer_2_place_1_surveys + self.answer_3_place_1_surveys + self.answer_4_place_1_surveys
  end

  def answer_place_2_surveys
    self.answer_1_place_2_surveys + self.answer_2_place_2_surveys + self.answer_3_place_2_surveys + self.answer_4_place_2_surveys
  end

  def answer_place_3_surveys
    self.answer_1_place_3_surveys + self.answer_2_place_3_surveys + self.answer_3_place_3_surveys + self.answer_4_place_3_surveys
  end

  def answer_place_1_surveys_value
    answer_place_1_surveys.size * 3
  end

  def answer_place_2_surveys_value
    answer_place_2_surveys.size * 2
  end

  def answer_place_3_surveys_value
    answer_place_3_surveys.size * 1
  end

  def answer_place_all_surveys_value
    answer_place_1_surveys_value + answer_place_2_surveys_value + answer_place_3_surveys_value
  end

end
