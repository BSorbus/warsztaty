class CreateRoleService
  # roles
  def work_observer
    role = Role.find_or_create_by!(name: "Obserwator Działań") do |role|
      role.activities += %w(all:work role:work user:work customer:work)
      role.note = "Rola służy do obserwowania historii wpisów, działań. \r\n (Przypisz tylko Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  def role_admin
    role = Role.find_or_create_by!(name: "Administrator Ról Systemowych") do |role|
      role.activities += %w(role:index role:show role:create role:update role:delete role:work)
      role.note = "Rola służy do tworzenia, modyfikowania Ról. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end 
  def role_observer
    role = Role.find_or_create_by!(name: "Obserwator Ról Systemowych") do |role|
      role.activities += %w(role:index role:show)
      role.note = "Rola służy do wyświetlania informacji o Rolach."
      role.save!
    end
  end

  # users
  def user_admin
    role = Role.find_or_create_by!(name: "Administrator Użytkowników") do |role|
      role.activities += %w(user:index user:show user:create user:update user:delete role:add_remove_role_user user:work)
      role.note = "Rola służy do zarządzania Użytkownikami i przypisywania im Ról Systemowych. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end
  def user_observer
    role = Role.find_or_create_by!(name: "Obserwator Użytkowników") do |role|
      role.activities += %w(user:index user:show)
      role.note = "Rola służy do wyświetlania informacji o Użytkownikach. \r\n (Przypisz Administratorom systemu oraz Koordynatorom POPC)"
      role.save!
    end
  end

  # questionnaires
  def questionnaire_admin
    role = Role.find_or_create_by!(name: "Administrator Ankiet") do |role|
      role.activities += %w(questionnaire:index questionnaire:show questionnaire:create questionnaire:update questionnaire:delete role:add_remove_role_questionnaire questionnaire:work)
      role.note = "Rola służy do zarządzania Ankietami. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end
  def questionnaire_writer
    role = Role.find_or_create_by!(name: "Ankieter") do |role|
      role.activities += %w(questionnaire:self_show questionnaire:self_create)
      role.note = "Rola pozwala wypełniać ankietę. \r\n (Przypisz Użytkownikom, którzy mają wypełnić ankietę)"
      role.save!
    end
  end


end
