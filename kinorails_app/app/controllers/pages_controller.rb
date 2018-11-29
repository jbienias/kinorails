class PagesController < ApplicationController

  def show
    render :file => "/pages/_help.html.erb"
  end

end
