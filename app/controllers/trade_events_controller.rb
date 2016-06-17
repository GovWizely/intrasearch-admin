class TradeEventsController < ApplicationController
  before_action :set_trade_event, only: [:show]

  def index
    @trade_events = TradeEvent.all pagination_params
  end

  def show
  end

  private

  def set_trade_event
    @trade_event = TradeEvent.find trade_event_param[:id]
  end

  def pagination_params
    params.permit(:page)
  end

  def trade_event_param
    params.permit(:id)
  end
end
