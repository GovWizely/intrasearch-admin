class TradeLeadsController < ApplicationController
  rescue_from ActiveResource::ResourceNotFound, with: :trade_lead_not_found
  before_action :authenticate_user!
  before_action :set_trade_lead, only: [:show, :edit, :update]

  def index
    @trade_leads = TradeLead.all pagination_params
  end

  def show
  end

  def edit
  end

  def update
    if @trade_lead.update_attributes update_params
      redirect_to trade_lead_path(@trade_lead), notice: 'You have successfully save this trade lead'
    else
      render :edit
    end
  end

  private

  def trade_lead_not_found
    redirect_to trade_leads_path, alert: 'Trade lead not found'
  end

  def set_trade_lead
    @trade_lead = TradeLead.find trade_lead_param[:id]
  end

  def pagination_params
    params.permit(:page)
  end

  def trade_lead_param
    params.permit(:id)
  end

  def update_params
    params.require(:trade_lead).permit(:md_description)
  end
end
