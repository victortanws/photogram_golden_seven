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

    a_new_photo.caption = params[:the_caption]
    a_new_photo.source = params[:the_source]

    a_new_photo.save

    redirect_to("http://localhost:3000/photos")
  end

  def destroy_row
    old_photo = Photo.find(params[:some_id])

    old_photo.destroy

    redirect_to("http://localhost:3000/photos")
  end

  def edit_form
    @existing_photo = Photo.find(params[:some_id])

    render("photos/edit_form.html.erb")
  end

  def update_row

    redirect_to("http://localhost:3000/photos/#{params[:some_id]}")
  end
end
