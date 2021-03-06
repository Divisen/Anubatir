class TendersController < ApplicationController
  before_action :set_tender, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @tenders = Tender.global_search(params[:query])
    else
    @tenders = Tender.all
    end
  end

  def show
    @marker = [{
      lat: @tender.latitude,
      lng: @tender.longitude
      # image_url: helpers.asset_url("marker_location.png")
    }]
  end

  def new
    @tender = Tender.new
  end

  def create
    @tender = Tender.new(tender_params)
    @tender.user = current_user
    if @tender.save
      redirect_to tender_path(@tender)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tender.update(tender_params)
      redirect_to tender_path(@tender)
    else
      render :new
    end
  end

  def destroy
    @tender.destroy
    redirect_to tenders_path
  end

  private

  def tender_params
    params.require(:tender).permit(:estimated_budget, :description, :nature_of_works, :location, :specifications, :estimated_start_date, :estimated_end_date, images:[])
  end

  def set_tender
    @tender = Tender.find(params[:id])
  end
end
