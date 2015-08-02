class HomeController < ApplicationController
  def index
  end

  def about
    @number = (1..46).to_a.sample(6)
    @name = "#{params[:first_name]} #{params[:last_name]}"
  end
end
