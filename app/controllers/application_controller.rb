class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :error, :warning
  include Pagy::Backend
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    added_attrs = %i[nik email password password_confirmation remember_me username]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def html_content(locals, partial: '')
    render_to_string(partial: partial,
                     formats: 'html',
                     layout: false,
                     locals: locals)
  end

  def error_content(locals, partial: '')
    render_to_string(partial: partial,
                     formats: 'html',
                     layout: false,
                     locals: locals)
  end

  # rescue_from ActionController::ParameterMissing do |exception|
  #   redirect_back(fallback_location: sasarans_path, flash: { error: "Belum dipilih" })
  # end
end
