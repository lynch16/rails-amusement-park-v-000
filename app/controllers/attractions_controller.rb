class AttractionsController < ApplicationController
  before_filter :current_user

  def index
    @attractions = Attraction.all
  end

  def new
    @attraction = Attraction.new
  end

  def create
    @attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(@attraction)
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update_attributes(attraction_params)
    @attraction.save
    redirect_to attraction_path(@attraction)
  end


  def ride
    @attraction = Attraction.find(params[:id])
    @ride = Ride.new(user: @user, attraction: @attraction)
    if @ride.take_ride.is_a?(String)
      redirect_to user_path(@user), alert: @ride.take_ride
    else
    @user.reload
    redirect_to user_path(@user), notice: "Thanks for riding the #{@attraction.name}!"
    end
  end

  private
  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :happiness_rating, :nausea_rating)
  end

end
