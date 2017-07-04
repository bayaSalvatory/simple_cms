class SectionsController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_page

  def index
    # @sections = Section.sorted
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id})
    @section_count = Section.count + 1
    @pages = @page.subject.pages.order('position ASC')
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = 'Section created Successfuly '
      redirect_to(controller: 'sections', action: 'index', :page_id => @page.id)
    else
      @section_count = Section.count + 1
      @pages = @page.subject.pages.order('position ASC')
      render('new')
    end
  end

  def edit
   @section = Section.find(params[:id])
   @section_count = Section.count
   @pages = @page.subject.pages.order('position ASC')
 end

 def update
  @section = Section.find(params[:id])
  if @section.update_attributes(section_params)
    flash[:notice] = 'Section Updated Successfuly' 
    redirect_to(controller: 'sections', action: 'show', id: @section.id, :page_id => @page.id)
  else
    @section_count = Section.count
    @pages = @page.subject.pages.order('position ASC')
    render('edit')
  end
end

def delete
 @section = Section.find(params[:id])
end

def destroy
  secton = Section.find(params[:id]).destroy
  flash[:notice] = 'Section deleted Successfuly '
  redirect_to(controller: 'sections', action: 'index', :page_id => @page.id)
end


private 

def section_params
  params.require(:section).permit(:name, :position, :visible, :content, :content_type, :page_id)
end

def find_page
  if params[:page_id]
    @page = Page.find(params[:page_id])
  end
end

end