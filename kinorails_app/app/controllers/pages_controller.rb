class PagesController < ApplicationController
  #todo
  
  def show
    @movies_selected = Movie.all
    if @movies_selected.length > 3
      rand_list = (0...@movies_selected.length).to_a.shuffle[0..2]

      movies_tmp = []

      rand_list.each do |num|
        movies_tmp << @movies_selected[num]
      end

      @movies_selected = movies_tmp
    end
    render :file => "/pages/_help.html.erb"
  end

end
