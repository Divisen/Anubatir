class TestimonialsController < ApplicationController
  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.user = current_user
    if @testimonial.save
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    @testimonial = Testimonial.find(params[:id])
    @testimonial.destroy
    redirect_to 'root'
  end

  def testimonial_params
    params.require(:testimonial).permit(:content, :rating)
  end
end
