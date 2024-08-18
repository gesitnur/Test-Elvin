# frozen_string_literal: true

class User::AppSettingsController < User::BaseController
  before_action :find_company
  before_action :find_app_setting

  def show; end

  def edit
    @industries = AppSetting.industries.keys.to_a
    @countries = build_select_options(Country.all)
    @states = build_select_options(State.all)
    @currencies = build_select_options(Currency.approved, { label: %i[code], value: :id })
    @fiscal_years = AppSetting.fiscal_years.keys.to_a
    @states = build_select_options(State.all)
    @start_dates = (1..31).to_a
    # authorize @app_setting
  end

  def update
    @app_setting = @company.app_setting.update(app_setting_params)
    @app_setting = @company.app_setting.update(working_day: params[:app_setting][:working_day].permit!.to_hash)
    redirect_to user_app_settings_path
  end

  private

  def find_company
    @company = current_user.company
  end

  def find_app_setting
    if @company.app_setting.blank?
      @currency = Currency.find_by_code('USD')
      @app_setting = @company.build_app_setting
      @app_setting.currency = @currency
      @app_setting.save
    end
    @app_setting = @company.app_setting
  end

  def app_setting_params
    params.require(:app_setting).permit(:company_name, :industry, :country_id, :street1, :street2, :city,
                                        :state_id, :zip_code, :phone, :fax, :website, :company_email,
                                        :currency_id, :fiscal_year, :start_date, :report_basis, :language_id,
                                        :term_and_condition, :company_logo, :customer_note)
  end
end
