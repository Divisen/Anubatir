class ContractsController < ApplicationController

  def index
    @contracts = Contract.all
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    @tender = Tender.find(params[:tender_id])
    @bid = Bid.find(params[:bid_id])
    Contract.create(bid_id: @bid.id, user_id: current_user.id, has_client_signed: true, completed: false, duration: @bid.duration)
    redirect_to user_path(current_user)
  end

  private

  def contract_params
    params.require(:contract).permit(:has_client_signed, :has_builder_signed, :completed, :images, :duration, :user_id, :bid_id)
  end
end
