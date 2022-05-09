# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @enrollment = @event.enrollments.new(user: current_user)
    if @enrollment.save
      redirect_to @event
    else
      flash[:alert] = @enrollment.errors.full_messages[0]
      redirect_to @event
    end
  end
end
