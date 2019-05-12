class ChartsController < ApplicationController

  PROVINCES = [['02', 'dolnośląskie'],
               ['04', 'kujawsko-pomorskie'],
               ['06', 'lubelskie'],
               ['08', 'lubuskie'],
               ['10', 'łódzkie'],
               ['12', 'małopolskie'],
               ['14', 'mazowieckie'],
               ['16', 'opolskie'],
               ['18', 'podkarpackie'],
               ['20', 'podlaskie'],
               ['22', 'pomorskie'],
               ['24', 'śląskie'],
               ['26', 'świętokrzyskie'],
               ['28', 'warmińsko-mazurskie'],
               ['30', 'wielkopolskie'],
               ['32', 'zachodniopomorskie']]


  before_action :authenticate_user!

  helper :all

  def departments_by_question_pie
    data_array = []
    Department.where.not(id: [1,2]).order(:short).each do |dep|
      data_array <<  ["#{dep.short}", 
                      sum_answer(dep, "#{params[:question]}") ]
    end
    render json: data_array 
  end

  def departments_sum_pie
    data_array = []
    Department.where.not(id: [1,2]).order(:short).each do |dep|
      data_array << ["#{dep.short}", 
                      sum_answer(dep, "1") + 
                      sum_answer(dep, "2") + 
                      sum_answer(dep, "3") + 
                      sum_answer(dep, "4") + 
                      sum_answer(dep, "5") ]
    end
    render json: data_array 
  end

  def departments_by_question_column
    data_array = [] 
    Department.where.not(id: [1,2]).order(:short).each do |department|  
      for answer in "#{params[:question]}".."#{params[:question]}" do
        data_array << { name: "#{department.short}", 
                        data: {"Pytanie #{answer}": sum_answer(department.id, answer) }
                      }         
      end
    end
    render json: data_array.to_json
  end


  def departments_sum_column
    data_array = [] 
    Department.where.not(id: [1,2]).order(:short).each do |department|  
      data_array << { name: "#{department.short}", 
                      data: {"Wszystkie pytania": sum_answer(department.id, "1") + 
                                                  sum_answer(department.id, "2") +
                                                  sum_answer(department.id, "3") +
                                                  sum_answer(department.id, "4") +
                                                  sum_answer(department.id, "5") }
                    }         
    end
    render json: data_array.to_json
  end

  def sum_answer(dep, answer)
    case answer.to_i
    when 1
      (Survey.where(answer_1_place_1: dep).count * 3) + 
      (Survey.where(answer_1_place_2: dep).count * 2) + 
      (Survey.where(answer_1_place_3: dep).count * 1) 
    when 2
      (Survey.where(answer_2_place_1: dep).count * 3) + 
      (Survey.where(answer_2_place_2: dep).count * 2) + 
      (Survey.where(answer_2_place_3: dep).count * 1) 
    when 3
      (Survey.where(answer_3_place_1: dep).count * 3) + 
      (Survey.where(answer_3_place_2: dep).count * 2) + 
      (Survey.where(answer_3_place_3: dep).count * 1)
    when 4
      (Survey.where(answer_4_place_1: dep).count * 3) + 
      (Survey.where(answer_4_place_2: dep).count * 2) + 
      (Survey.where(answer_4_place_3: dep).count * 1) 
    when 5
      (Survey.where(answer_5_place_1: dep).count * 3) + 
      (Survey.where(answer_5_place_2: dep).count * 2) + 
      (Survey.where(answer_5_place_3: dep).count * 1) 
    end

  end

  def point_files
    data_array = []
    PROVINCES.each do |province|
      data_array << [ province[0], PointFile.where(status: [:active], oi_4: province[1].mb_chars.upcase).count ]
    end
    render json: data_array.to_json
  end

  def xml_miejsce_realizacji_tables
    data_array = []
    PROVINCES.each do |province|
      data_array << [ province[0], XmlMiejsceRealizacjiTable.joins(xml_partner_table: [:proposal_file]).where(wojewodztwo_opis: province[1].mb_chars.upcase, xml_partner_tables: {proposal_files: {status: [:active]}}).count ]
    end
    render json: data_array.to_json
  end


  private
    

end
