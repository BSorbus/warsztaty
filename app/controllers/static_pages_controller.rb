class StaticPagesController < ApplicationController

  caches_page :home, :introduction, :job_1, :job_2, :job_3, :job_4, :job_5, :gzip => :best_speed

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

  def job_5
  end

end
