class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]
  before_action :set_tender, only: [:new, :create, :update, :index]

  def receipt
    @bid = Bid.find(params[:id])
    Receipts::Statement.new(
      details: [
        ["Receipt Number", "123"],
        ["Date paid", Date.today],
        ["Payment method", "Internet Bank Transfer"]
      ],
      company: {
        name: "#{@bid.user.company_name}",
        address: "#{@bid.user.address}",
        email: "#{@bid.user.email}",
        logo: Rails.root.join("app/assets/images/biglogo.png")
      },
      recipient: [
        "#{@bid.tender.user.first_name} #{@bid.tender.user.last_name}",
        "#{@bid.tender.user.address}",
        "City, State Zipcode",
        nil,
        "#{@bid.tender.user.email}"
      ],
      line_items: [
        ["<b>Item</b>", "<b>Unit Cost</b>", "<b>Quantity</b>", "<b>Amount</b>"],
        ["Subscription", "$19.00", "1", "$19.00"],
        [nil, nil, "Subtotal", "$19.00"],
        [nil, nil, "Tax", "$1.12"],
        [nil, nil, "Total", "$20.12"],
        [nil, nil, "<b>Amount paid</b>", "$20.12"],
        [nil, nil, "Refunded on #{Date.today}", "$5.00"]
      ],
      footer: "Thanks for your business. Please contact us if you have any questions.")
  end

  def index
    @bids = Bid.where tender_id: @tender.id
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.pdf { send_data(receipt.render, filename: "#{@bid.created_at.strftime("%Y-%m-%d")}-anubatir-receipt.pdf", type: "application/pdf", disposition: :inline) }
    end
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
    params.require(:bid).permit(:quote, :approved, items_attributes:[:id, :name, :quantity, :unit, :unit_rate, :amount, :_destroy])
  end

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def set_tender
    @tender = Tender.find(params[:tender_id])
  end
end
