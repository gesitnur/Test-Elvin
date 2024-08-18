class User::CalendarsController < ApplicationController
  before_action :authenticate_user!
  layout 'owner_layout'

  def index
    @company_holiday = CompanyHoliday.new
    @countries = build_select_options(Country.all, { label: %i[name], value: :code })
  end

  def create
    @company_holiday = CompanyHoliday.new(holiday_params)

    if @company_holiday.save
      flash[:notice] = "Company Holiday successfully created"
    else
      flash[:alert] = @company_holiday.errors.full_messages.to_sentence
    end
  end

  def get_holidays
    leave_requests = WorkLeaveRequest.approved
    convert_leave_request = leave_requests.map{|leave_request| { title:"#{leave_request.user.name} (#{ leave_request.leave_type.name})",
                                                  start: date_formater(leave_request.start_date, '%Y-%m-%d'),
                                                  end: date_formater(leave_request.end_date + 1, '%Y-%m-%d'),
                                                  backgroundColor: "##{leave_request.leave_type.colour_code}",
                                                  classNames: 'leave-calendar',
                                                  id: leave_request.id } }

    holidays = CompanyHoliday.all
    convert_holidays = holidays.map{|holiday| { title: holiday.name,
                                                start: date_formater(holiday.start_date, '%Y-%m-%d'),
                                                end: date_formater(holiday.end_date + 1, '%Y-%m-%d') } }

    working_day = current_user.company.app_setting.working_day.map{|a| Date.strptime(a[0], '%A').wday if a[1].eql?('1')}

    respond_to do |format|
      format.json { render json: { convert_holidays: convert_holidays + convert_leave_request, working_day: working_day.compact.to_s }, status: 200 }
      format.html
    end
  end

  def leave_modal
    @work_leave_request = WorkLeaveRequest.find(params[:id])
    @leave_type_collections = LeaveType.all
  end

  def import_holiday
    begin
      sheet = Roo::Spreadsheet.open(params[:import_file])

      (2..sheet.last_row).each do |row|
        record = sheet.row(row)
        company_holiday = CompanyHoliday.create(name: record[0],
                                                start_date: record[1],
                                                end_date: record[2],
                                                company: current_user.company)
      end
      flash[:notice] = "Company Holiday successfully imported"
    rescue StandardError => e
      flash[:alert] = e.message
    end
  end

  def download_template
    send_file 'public/xlsx/sample_company_holidays_new.xlsx'
  end

  private

  def holiday_params
    params.require(:company_holiday).permit(:name, :start_date, :end_date, :company_id)
  end
end
