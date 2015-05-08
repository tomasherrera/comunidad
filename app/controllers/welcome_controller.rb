class WelcomeController < ApplicationController
  layout false, only: [:index, :gameview]

  def index
  end

  def home
  end

  def gameview
  end
end
