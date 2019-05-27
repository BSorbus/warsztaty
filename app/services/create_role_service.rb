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
  # users
  def user_admin
    role = Role.find_or_create_by!(name: "Administrator Użytkowników") do |role|
      role.activities += %w(user:index user:show user:create user:update user:delete role:add_remove_role_user user:work)
      role.note = "Rola służy do zarządzania Użytkownikami i przypisywania im Ról Systemowych. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end
  # surveys
  def survey_admin
    role = Role.find_or_create_by!(name: "Administrator Ankiet") do |role|
      role.activities += %w(survey:index survey:show survey:create survey:update survey:delete survey:work)
      role.note = "Rola służy do zarządzania Ankietami. \r\n (Przypisz tylko zaawansowanym Administratorom systemu)"
      role.save!
    end
  end
  def survey_writer
    role = Role.find_or_create_by!(name: "Wypełniający Ankietę") do |role|
      role.activities += %w(survey:index_self survey:show_self survey:create_self survey:update_self survey:delete_self)
      role.note = "Rola pozwala wypełniać ankietę. \r\n (Przypisz Użytkownikom, którzy mają wypełnić ankietę)"
      role.save!
    end
  end
  # surveys
  def exposition_admin
    role = Role.find_or_create_by!(name: "Administrator Galerii Obrazów") do |role|
      role.activities += %w(exposition:index exposition:show exposition:create exposition:update exposition:delete exposition:work)
      role.note = "Rola służy do zarządzania Galerią obrazów. \r\n (Przypisz tylko zaawansowanym Użytkownikom systemu)"
      role.save!
    end
  end


end
