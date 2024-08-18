class User::CompanyHolidaysController <  User::BaseCrudController
  def index
    @company_holiday = CompanyHoliday.new
  end
end
