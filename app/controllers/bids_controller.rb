class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :activate]
  before_action :set_tender, only: [:new, :create, :update, :index]

  def receipt
    @bid = Bid.find(params[:id])

    @items = @bid.items.map do |item|
      item
    end

    Receipts::Receipt.new(
      font: {
        bold: Rails.root.join('app/assets/fonts/poppins/Poppins-Bold.ttf'),
        normal: Rails.root.join('app/assets/fonts/poppins/Poppins-Medium.ttf'),
      },
      details: [
        ["Receipt Number", "123"],
        ["Date paid", Date.today],
        ["Payment method", "Internet Bank Transfer"],
        [""],
        [""],
        [""],
        [""],
        [""],
        [""],
        [""],
        [""],
        ["<b>Contractor Details</b>                                                                            <b>Client Details</b>" ]
      ],
      company: {
        name: "Company: #{@bid.user.company_name}",
        address: "Address: #{@bid.user.address}",
        email: "Email: #{@bid.user.email}",
        logo: File.expand_path("app/assets/images/logo.png")
      },
      recipient: [
        "<b>Name: #{@bid.tender.user.first_name} #{@bid.tender.user.last_name}</b>",
        "Address: #{@bid.tender.user.address}",
        #nil,
        "Email: #{@bid.tender.user.email}"
      ],
      line_items: [
        ["<b>Name</b>", "<b>Quantity</b>", "<b>Unit</b>", "<b>Unit Rate</b>", "<b>Amount (Rs)</b>", "<b>Duration (Days)</b>"],
        ["#{@items[0].nil? ? nil : @items[0].name}","#{@items[0].nil? ? nil : @items[0].quantity}", "#{@items[0].nil? ? nil : @items[0].unit}", "#{@items[0].nil? ? nil : @items[0].unit_rate}", "#{@items[0].nil? ? nil : @items[0].amount}", "#{@items[0].nil? ? nil : @items[0].duration}" ],
        ["#{@items[1].nil? ? nil : @items[1].name}","#{@items[1].nil? ? nil : @items[1].quantity}", "#{@items[1].nil? ? nil : @items[1].unit}", "#{@items[1].nil? ? nil : @items[1].unit_rate}", "#{@items[1].nil? ? nil : @items[1].amount}", "#{@items[1].nil? ? nil : @items[1].duration}" ],
        ["#{@items[2].nil? ? nil : @items[2].name}","#{@items[2].nil? ? nil : @items[2].quantity}", "#{@items[2].nil? ? nil : @items[2].unit}", "#{@items[2].nil? ? nil : @items[2].unit_rate}", "#{@items[2].nil? ? nil : @items[2].amount}", "#{@items[2].nil? ? nil : @items[2].duration}" ],
        ["#{@items[3].nil? ? nil : @items[3].name}","#{@items[3].nil? ? nil : @items[3].quantity}", "#{@items[3].nil? ? nil : @items[3].unit}", "#{@items[3].nil? ? nil : @items[3].unit_rate}", "#{@items[3].nil? ? nil : @items[3].amount}", "#{@items[3].nil? ? nil : @items[3].duration}" ],
        ["#{@items[4].nil? ? nil : @items[4].name}","#{@items[4].nil? ? nil : @items[4].quantity}", "#{@items[4].nil? ? nil : @items[4].unit}", "#{@items[4].nil? ? nil : @items[4].unit_rate}", "#{@items[4].nil? ? nil : @items[4].amount}", "#{@items[4].nil? ? nil : @items[4].duration}" ],
        ["#{@items[5].nil? ? nil : @items[5].name}","#{@items[5].nil? ? nil : @items[5].quantity}", "#{@items[5].nil? ? nil : @items[5].unit}", "#{@items[5].nil? ? nil : @items[5].unit_rate}", "#{@items[5].nil? ? nil : @items[5].amount}", "#{@items[5].nil? ? nil : @items[5].duration}" ],
        ["#{@items[6].nil? ? nil : @items[6].name}","#{@items[6].nil? ? nil : @items[6].quantity}", "#{@items[6].nil? ? nil : @items[6].unit}", "#{@items[6].nil? ? nil : @items[6].unit_rate}", "#{@items[6].nil? ? nil : @items[6].amount}", "#{@items[6].nil? ? nil : @items[6].duration}" ],
        ["#{@items[7].nil? ? nil : @items[7].name}","#{@items[7].nil? ? nil : @items[7].quantity}", "#{@items[7].nil? ? nil : @items[7].unit}", "#{@items[7].nil? ? nil : @items[7].unit_rate}", "#{@items[7].nil? ? nil : @items[7].amount}", "#{@items[7].nil? ? nil : @items[7].duration}" ],
        ["#{@items[8].nil? ? nil : @items[8].name}","#{@items[8].nil? ? nil : @items[8].quantity}", "#{@items[8].nil? ? nil : @items[8].unit}", "#{@items[8].nil? ? nil : @items[8].unit_rate}", "#{@items[8].nil? ? nil : @items[8].amount}", "#{@items[8].nil? ? nil : @items[8].duration}"  ],
        ["#{@items[9].nil? ? nil : @items[9].name}","#{@items[9].nil? ? nil : @items[9].quantity}", "#{@items[9].nil? ? nil : @items[9].unit}", "#{@items[9].nil? ? nil : @items[9].unit_rate}", "#{@items[9].nil? ? nil : @items[9].amount}", "#{@items[9].nil? ? nil : @items[9].duration}"  ],
        ["#{@items[10].nil? ? nil : @items[10].name}","#{@items[10].nil? ? nil : @items[10].quantity}", "#{@items[10].nil? ? nil : @items[10].unit}", "#{@items[10].nil? ? nil : @items[10].unit_rate}", "#{@items[10].nil? ? nil : @items[10].amount}", "#{@items[10].nil? ? nil : @items[10].duration}" ],
        ["<b>Total amount to be paid:</b>", "Rs #{@bid.quote}", "&", "<b>Project Duration:</b>", "#{@bid.duration} Days"],
        # [nil, nil, nil, "<b>Total duration</b>", "#{@bid.duration} Days"]
      ],
      footer: "Thanks for your business. Please contact us if you have any questions.")
  end

  def index
    @bids = Bid.where tender_id: @tender.id
  end

  def show
    @skip_footer = true
    respond_to do |format|
      format.html
      format.json
      format.pdf { send_data(receipt.render, filename: "#{@bid.created_at.strftime("%Y-%m-%d")}-anubatir-receipt.pdf", type: "application/pdf", disposition: :inline) }
    end
  end

  def new
    @bid = Bid.new
    @bid.user = current_user
    @skip_footer = true
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

  def activate
    @bid.update(approved: true)
    @tender = Tender.find(params[:tender_id])
    @bids = Bid.where tender_id: @tender.id
    rejects = @bids.reject do |rejected_bid|
      rejected_bid.approved == true
    end
    rejects.each do |reject|
      reject.update(rejected: true)
    end

    # redirect_to tender_path(@tender)
  end

  # def reject
  #   @tender = Tender.find(params[:tender_id])
  #   @bids = Bid.where tender_id: @tender.id
  #   rejects = @bids.reject do |rejected_bid|
  #     rejected_bid.approved == true
  #   end
  #   rejects.each do |reject|
  #     reject.update(rejected: true)
  #   end

  #   redirect_to tender_path(@tender)
  # end


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
    params.require(:bid).permit(:quote, :approved, :rejected, :duration, items_attributes:[:id, :name, :quantity, :unit, :unit_rate, :amount, :duration, :_destroy])
  end

  def set_bid
    @bid = Bid.find(params[:id])
  end

  def set_tender
    @tender = Tender.find(params[:tender_id])
  end
end
