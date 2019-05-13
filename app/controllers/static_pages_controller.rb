class StaticPagesController < ApplicationController

  caches_page :home, :introduction, :gzip => :best_speed

  def home
  end

  def introduction
  end

  def job_1
  end

  def job_2
  end

  def job_3
  end

  def job_4
  end

end
