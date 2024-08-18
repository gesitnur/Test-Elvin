# frozen_string_literal: true

class Admin::RemainingDayOffsController < Admin::BaseCrudController
  

  def create
    @remaining_day_off = RemainingDayOff.new
    @remaining_day_off.update(remaining_day_off_params)
    if @remaining_day_off.save
      flash[:notice] = 'Update Data Successfully'
    else
      flash[:alert] = @remaining_day_off.errors.full_messages.to_sentence
    end

    User.all.update_all(leave_request_balance: @remaining_day_off.remaining)

    # redirect_to admin_remaining_day_offs_path
    respond_to do |format|
      format.js
    end
  end

  private

  def remaining_day_off_params
    params.require(:remaining_day_off).permit(:remaining, :year)
  end
end
