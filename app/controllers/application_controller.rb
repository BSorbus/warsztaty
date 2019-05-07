class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	 
#  before_action :set_locale
  before_action :restricted_area, if: :devise_controller_registrations_new
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :request_from_the_security_area?

  # def default_url_options
  #   { locale: I18n.locale }
  # end

#  private

    # def set_locale
    #   I18n.locale = params[:locale] || I18n.default_locale
    # end

  protected

    def devise_controller_registrations_new
      :devise_controller? && "#{controller_name}" == 'registrations' && "#{action_name}" == 'new'
    end

    def restricted_area
      unless request_from_the_security_area?
        mess = t("restricted_area")
        if request.format == 'application/json'
          render status: :forbidden, json: {error: "#{mess}"} and return
        else
          flash[:error] = "#{mess}" if is_flashing_format?
          redirect_to(request.referrer || root_path) 
        end
      end
    end 

    def request_from_the_security_area?
      @ips = [
              '127.0.0.1',        # localhost
              '10.2.0.0/16',      # Białystok 
              '10.3.0.0/16',      # Bydgoszcz
              '10.4.0.0/16',      # Gdynia
              '10.5.0.0/16',      # Siemianowice Śląskie
              '10.6.0.0/16',      # Kielce
              '10.7.0.0/16',      # Koszalin
              '10.8.0.0/16',      # Kraków
              '10.9.0.0/16',      # Lublin
              '10.10.0.0/16',     # Łódź
              '10.11.0.0/16',     # Olsztyn
              '10.12.0.0/16',     # Poznań
              '10.13.0.0/16',     # Rzeszów
              '10.14.0.0/16',     # Szczecin
              '10.15.0.0/16',     # Wrocław
              '10.16.0.0/16',     # Zielona Góra
              '10.17.0.0/16',     # Opole
              '10.18.0.0/16',     # Borucza
              '10.19.0.0/16',     # DZC Wrocław
              '10.20.0.0/16',     # Centrala
              '10.21.0.0/16',     # Centrala
              '10.100.0.0/16',    # Centrala proxy
              '172.16.1.0/24',
              '10.250.125.0/24',  # Połączenia VPN BYBI
              '10.250.118.0/24',  # Galach VPN
              '10.250.119.0/24',  # Piotr Majewski VPN
              '10.250.105.0/24'   # Radek Michałek, Andrzej Kaczor VPN
            ] 
      allowed = false
      # Convert remote IP (request.remote_ip is a string) to an integer.
      bremote_ip = request.remote_ip.split('.').map(&:to_i).pack('C*').unpack('N').first
      @ips.each do |ipstring|
        ip, mask = ipstring.split '/'
        # Convert tested IP to an integer.
        bip = ip.split('.').map(&:to_i).pack('C*').unpack('N').first
        # Convert mask to an integer, and assume /32 if not specified.
        mask = mask ? mask.to_i : 32
        bmask = ((1 << mask) - 1) << (32 - mask)
        if bip & bmask == bremote_ip & bmask
          allowed = true
          break
        end
      end

      return allowed
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
   
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:name, :email, :department_id, :position, :password, :password_confirmation)
      end
   
      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit(:name, :email, :department_id, :position, :password, :password_confirmation, :current_password)
      end

    end

end
