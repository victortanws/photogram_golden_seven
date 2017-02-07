class PhotosController < ApplicationController
  def index
    @list_of_photos = Photo.all

    render("photos/index.html.erb")
  end

  def show
    @the_photo = Photo.find(params[:some_id])

    render("photos/show.html.erb")
  end

  def new_form

    render("photos/new_form.html.erb")
  end

  def create_row
    a_new_photo = Photo.new

    a_new_photo.save

    redirect_to("http://localhost:3000/photos")
  end
end
