class ChartsController < ApplicationController
  before_action :authenticate_user!

  helper :all

  def departments_by_question_pie
    data_array = []
    Department.where.not(id: [1,2,3]).order(:short).each do |dep|
      data_array <<  ["#{dep.short}", 
                      sum_answer(dep, "#{params[:question]}") ]
    end
    render json: data_array 
  end

  def departments_sum_pie
    data_array = []
    Department.where.not(id: [1,2,3]).order(:short).each do |dep|
      data_array << ["#{dep.short}", 
                      sum_answer(dep, "1") + 
                      sum_answer(dep, "2") + 
                      sum_answer(dep, "3") + 
                      sum_answer(dep, "4") ] 
    end
    render json: data_array 
  end

  def departments_by_question_column
    data_array = [] 
    Department.where.not(id: [1,2,3]).order(:short).each do |department|  
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
    Department.where.not(id: [1,2,3]).order(:short).each do |department|  
      data_array << { name: "#{department.short}", 
                      data: {"Wszystkie pytania": sum_answer(department.id, "1") + 
                                                  sum_answer(department.id, "2") +
                                                  sum_answer(department.id, "3") +
                                                  sum_answer(department.id, "4") }
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
    end

  end    

end
