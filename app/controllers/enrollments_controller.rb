# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    enrollment = Enrollment.new(enrollment_params)
    if enrollment.save
    else
      flash[:alert] = enrollment.errors.full_messages[0]
    end
    redirect_to @event
  end

  def update
    @event = Event.find(params[:event_id])
    @enrollment = @event.enrollments.find(params[:id])
    if @enrollment.update(status: params[:status])
      flash[:notice] = 'Enrollment successfully updated'
    else
      flash[:alert] = @enrollment.errors.full_messages[0]
    end
    redirect_to @event
  end

  private

  def enrollment_params
    params.require(:enrollment).permit(:event_id, :user_id, :status)
  end
end
