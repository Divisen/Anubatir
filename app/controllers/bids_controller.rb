class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :set_tender_and_user, only: [:new, :create, :update]

  def index
    @bids = Bid.all
  end

  def show
  end

  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.tender = @tender
    if @bid.save
      redirect_to bid_path(@bid)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @bid.tender = @tender
    if @bid.update(bid_params)
      redirect_to bid_path(@bid)
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

  def set_tender_and_user
    # @bid.user.id = current_user.id
    @tender = Tender.find(params[:tender_id])
  end
end
