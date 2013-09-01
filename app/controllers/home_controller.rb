class HomeController < ApplicationController
  def index
    @notes = current_user ? current_user.notes : nil
  end
end
