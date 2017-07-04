class PublicController < ApplicationController

	layout 'public'

  before_action :setup_navigation

  def index
  	# intro text
  end

  def show
  	# .first, Returns the first record found.
  	@page = Page.where(:permalink => params[:permalink], :visible => true).first

  	if @page.nil?
  		redirect_to(:action => 'index')
  	else
  		# Display the page content using show.html.erb
  	end
  end

  private

  def setup_navigation
      @subjects = Subject.visible.sorted
  end
end
