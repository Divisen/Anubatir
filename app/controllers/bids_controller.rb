class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :set_tender, only: [:new, :create, :update, :index]

  def index
    @bids = Bid.where tender_id: @tender.id
  end

  def show
  end

  def new
    @bid = Bid.new
    @bid.user = current_user
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.tender = @tender
    @bid.user = current_user
    if @bid.save
      redirect_to tender_path(@tender)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @bid.tender = @tender
    @bid.user = current_user
    if @bid.update(bid_params)
      redirect_to tender_path(@tender)
    else
      render :new
    end
  end

  def destroy
    @bid.destroy
    redirect_to bids_path
  end

  private

  def bid_params
    params.require(:bid).permit(:quote, :approved)
  end

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def set_tender
    @tender = Tender.find(params[:tender_id])
  end
end
