class ContractsController < ApplicationController

  def index
    @contracts = Contract.all
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @bid = Bid.find(params[:bid_id])
    @contract.bid = @bid
    if @contract.save
      redirect_to contract_path(@contract)
    else
      render 'contracts/show'
    end
  end

  private

  def contract_params
    params.require(:contract).permit(:has_client_signed, :has_builder_signed, :completed, :images, :duration)
  end
end
