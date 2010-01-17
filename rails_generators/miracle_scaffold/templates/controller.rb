class <%= plural_class_name %>Controller < ApplicationController
  
  # 
  # RESTful actions
  #
  
  def index
    @<%= plural_name %> = <%= class_name %>.all
  end
  
  def show
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end
  
  def new
    @<%= singular_name %> = <%= class_name %>.new
  end

  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])
    
    if @<%= singular_name %>.save
      flash[:notice] = "<%= singular_name.titleize %> added successfully."
      redirect_to <%= plural_name %>_path
    else
      render :action => :new
    end
  end

  def edit
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end

  def update
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    
    if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
      flash[:notice] = "<%= singular_name.titleize %> updated successfully."
      redirect_to <%= plural_name %>_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    <%= class_name %>.find(params[:id]).destroy
    flash[:notice] = "<%= singular_name.titleize %> deleted successfully."
    redirect_to <%= plural_name %>_path
  end
  
end
