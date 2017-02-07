class PhotosController < ApplicationController


  def index
    @list_of_photos = Photo.all

    render("photos/index.html.erb")
  end

  def show
    @photo = Photo.find_by(:id => params[:id])

  end

  def new_form

  end

  def create_row
    p = Photo.new
    p.caption = params[:the_caption]
    p.source = params[:the_source]
    p.save

    redirect_to("http://localhost:3000/photos")

  end

  def destroy
    @photo = Photo.find_by(:id => params[:id])
    @photo.destroy
    redirect_to("http://localhost:3000/photos")

  end

  def edit_form
    @photo = Photo.find_by(:id => params[:id])

  end

  def update_row
    @photo = Photo.find_by(:id => params[:id])
    @photo.source = params[:the_url]
    @photo.caption = params[:the_caption]
    @url1 = "http://localhost:3000/photos/"
    @url2 = @photo.id.to_s
    @url = @url1 + @url2

    @photo.save
    redirect_to(@url)

  end

end
