class TradeEventsController < ApplicationController
  rescue_from ActiveResource::ResourceNotFound, with: :trade_event_not_found
  before_action :authenticate_user!
  before_action :set_trade_event, only: [:show, :edit, :update]

  def index
    @trade_events = TradeEvent.all pagination_params
  end

  def show
  end

  def edit
  end

  def update
    if @trade_event.update_attributes update_params
      redirect_to trade_event_path(@trade_event), notice: 'You have successfully save this trade event'
    else
      render :edit
    end
  end

  private

  def trade_event_not_found
    redirect_to trade_events_path, alert: 'Trade event not found'
  end

  def set_trade_event
    @trade_event = TradeEvent.find trade_event_param[:id]
  end

  def pagination_params
    params.permit(:page)
  end

  def trade_event_param
    params.permit(:id)
  end

  def update_params
    params.require(:trade_event).permit(:md_description)
  end
end
