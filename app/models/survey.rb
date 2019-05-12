require 'csv'
class Survey < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  belongs_to :user
  has_many :works, as: :trackable


  validates :answer_1_place_1, presence: true
  validates :answer_1_place_2, presence: true
  validates :answer_1_place_3, presence: true
  validates :answer_2_place_1, presence: true
  validates :answer_2_place_2, presence: true
  validates :answer_2_place_3, presence: true
  validates :answer_3_place_1, presence: true
  validates :answer_3_place_2, presence: true
  validates :answer_3_place_3, presence: true
  validates :answer_4_place_1, presence: true
  validates :answer_4_place_2, presence: true
  validates :answer_4_place_3, presence: true
  validates :answer_5_place_1, presence: true
  validates :answer_5_place_2, presence: true
  validates :answer_5_place_3, presence: true

  validate :answer_1
  validate :answer_2
  validate :answer_3
  validate :answer_4
  validate :answer_5


  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.role_path(self)}"
    worker_id = action_user_id
    Work.create!(trackable_type: 'Survey', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
      parameters: self.to_json(except: [:user_id], include: {user: {only: [:id, :name, :email]}}))
  end

  def self.to_csv
    CSV.generate(headers: false, col_sep: ';', converters: nil, skip_blanks: false, force_quotes: false) do |csv|
      columns_header = %w(Wypełnił Delegatura Utworzono Aktualizowano)
      csv << columns_header
      all.each do |rec|
        csv << [rec.user.fullname,
                rec.user.department.short,
                rec.created_at.strftime('%Y-%m-%d %H:%M:%S'),
                rec.updated_at.strftime('%Y-%m-%d %H:%M:%S')]
     end
    end.encode('WINDOWS-1250')
  end

  def fullname
    "#{self.user.name} [ostatnia aktualizacja: #{self.updated_at.strftime('%Y-%m-%d %H:%M:%S')}]"
  end

  def number_as_link
    "<a href=#{url_helpers.survey_path(self)}>#{self.user.name}</a>".html_safe
  end

  private

    def answer_1
      analize_value = true
      return if answer_1_place_1.blank? || answer_1_place_2.blank? || answer_1_place_3.blank?
     
      if answer_1_place_1 == answer_1_place_2
        errors.add(:answer_1_place_2, 'Pytanie 1 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_1_place_1 == answer_1_place_3
        errors.add(:answer_1_place_3, 'Pytanie 1 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_1_place_2 == answer_1_place_3
        errors.add(:answer_1_place_3, 'Pytanie 1 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      throw :abort unless analize_value
    end

    def answer_2
      analize_value = true
      return if answer_2_place_1.blank? || answer_2_place_2.blank? || answer_2_place_3.blank?
     
      if answer_2_place_1 == answer_2_place_2
        errors.add(:answer_2_place_2, 'Pytanie 2 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_2_place_1 == answer_2_place_3
        errors.add(:answer_2_place_3, 'Pytanie 2 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_2_place_2 == answer_2_place_3
        errors.add(:answer_2_place_3, 'Pytanie 2 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      throw :abort unless analize_value
    end

    def answer_3
      analize_value = true
      return if answer_3_place_1.blank? || answer_3_place_2.blank? || answer_3_place_3.blank?
     
      if answer_3_place_1 == answer_3_place_2
        errors.add(:answer_3_place_2, 'Pytanie 3 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_3_place_1 == answer_3_place_3
        errors.add(:answer_3_place_3, 'Pytanie 3 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_3_place_2 == answer_3_place_3
        errors.add(:answer_3_place_3, 'Pytanie 3 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      throw :abort unless analize_value
    end

    def answer_4
      analize_value = true
      return if answer_4_place_1.blank? || answer_4_place_2.blank? || answer_4_place_3.blank?
     
      if answer_4_place_1 == answer_4_place_2
        errors.add(:answer_4_place_2, 'Pytanie 4 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_4_place_1 == answer_4_place_3
        errors.add(:answer_4_place_3, 'Pytanie 4 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_4_place_2 == answer_4_place_3
        errors.add(:answer_4_place_3, 'Pytanie 4 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      throw :abort unless analize_value
    end

    def answer_5
      analize_value = true
      return if answer_5_place_1.blank? || answer_5_place_2.blank? || answer_5_place_3.blank?
     
      if answer_5_place_1 == answer_5_place_2
        errors.add(:answer_5_place_2, 'Pytanie 5 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_5_place_1 == answer_5_place_3
        errors.add(:answer_5_place_3, 'Pytanie 5 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      if answer_5_place_2 == answer_5_place_3
        errors.add(:answer_5_place_3, 'Pytanie 5 - Określona Delegatura może występić w wynikach poszczególnych pytań tylko raz') 
        analize_value = false 
      end 
      throw :abort unless analize_value
    end


end
