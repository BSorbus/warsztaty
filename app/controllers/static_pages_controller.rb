class StaticPagesController < ApplicationController

  caches_page :home, :introduction, :gzip => :best_speed

  def home
  end

  def introduction
  end


end
