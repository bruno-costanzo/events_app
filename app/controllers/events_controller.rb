# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.all.future.order(date: :asc)
  end

  def show
    @event = Event.find(params[:id])
    @uninvited_users = User.uninvited_to(@event) if current_user.host?(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.new(event_params)
    if @event.save
      flash[:notice] = 'Event successfully created'
      redirect_to @event
    else
      flash[:alert] = @event.errors.full_messages[0]
      redirect_to new_event_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :host_id, :location, :date, :cover, :private)
  end
end
