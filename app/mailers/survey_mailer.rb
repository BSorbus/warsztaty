class SurveyMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_provider_username
  default cc: Rails.application.secrets.email_provider_username

  def send_score_email
    # students = [ { name: "Mary Jones", test_score: 80, sport: "soccer" },
    #              { name: "Bob Kelly", test_score: 95, sport: "basketball" },
    #              { name: "Kate Saunders", test_score: 99, sport: "hockey" },
    #              { name: "Pete Dunst", test_score: 88, sport: "football" },
    #              { name: "Ima Hogg", test_score: 99, sport: "darts" }
    #            ]

    #max_score = students.max_by { |h| h[:test_score] }[:test_score]
      #=> 99 

    #star_students = students.select { |h| h[:test_score] == max_score }.
    #                         map { |h| h[:name] }
      #=> ["Kate Saunders", "Ima Hogg"] 

    scores = []
    Department.all.each do |department|
      scores << { department_short: department.short,
                  department_name: department.name, 
                  department_score: department.answer_place_all_surveys_value}
    end

    max_score = scores.max_by{|k| k[:department_score]}[:department_score]

    @star_departments_shorts = scores.select { |h| h[:department_score] == max_score }.map { |h| h[:department_short] }
    @star_departments_names = scores.select { |h| h[:department_score] == max_score }.map { |h| h[:department_name] }

    attachments.inline['logo.jpg'] = File.read("app/assets/images/app_logo.png")
    attachments.inline['puchar.jpg'] = File.read("app/assets/images/puchar.png")
    attachments.inline['logo_uke.jpg'] = File.read("app/assets/images/logo_uke_pl_do_lewej_small.png")
    users_emails = User.all.flat_map {|row| row.email}
    #mail(to: users_emails.join(','), subject: "WARSZTATY RSP - wyniki ankiety" )
    mail(to: "bogdan.jarzab@uke.gov.pl,bogdan.jarzab@uke.gov.pl,bogdan.jarzab@uke.gov.pl", subject: "WARSZTATY RSP - wyniki ankiety" )
  end

end

# preview
# http://localhost:3000/rails/mailers/status_mailer/project_status_email.html