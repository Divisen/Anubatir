class ContractsController < ApplicationController

  # def index
  #   @contracts = Contract.all
  # end

  # def new
  #   @contract = Contract.new
  # end

  # def create
  #   @contract = Contract.new(contract_params)
  #   @contract.bid = @bid
  #   @contract.user = current_user
  #   if @contract.save
  #     redirect_to contract_path(@contract)
  #   else
  #     render 'contracts/show'
  #   end
  # end

  # def edit
  # end

  # def update
  # end

  # private

  # def contract_params
  #   params.require(:contract).permit(:has_client_signed, :has_builder_signed, :completed, :images, :duration)
  # end
end
