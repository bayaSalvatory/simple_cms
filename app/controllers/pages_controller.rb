class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject
  
  def index
    # @pages = Page.where(:subject_id => @subject.id).sorted
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => "Default"})
    @page_count = Page.count + 1
    @subjects = Subject.order('position ASC')
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:notice] = 'Page created Successfuly '
      redirect_to(controller: 'pages', action: 'index', :subject_id => @subject.id)
    else
       @page_count = Page.count + 1
       @subjects = Subject.order('position ASC')
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
     @page_count = Page.count
     @subjects = Subject.order('position ASC')
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = 'Page Updated Successfuly' 
      redirect_to(controller: 'pages', action: 'show', id: @page.id, :subject_id => @subject.id)
    else
       @page_count = Page.count
       @subjects = Subject.order('position ASC')
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = 'Page deleted Successfuly '
    redirect_to(controller: 'pages', action: 'index', :subject_id => @subject.id)
  end

  private 

  def page_params
    params.require(:page).permit(:name, :position, :permalink, :visible, :subject_id)
  end

  def find_subject
    if params[:subject_id]
      @subject = Subject.find(params[:subject_id])
    end
  end

end
