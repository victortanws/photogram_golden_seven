Rails.application.routes.draw do

  get("/", { :controller => "photos", :action => "index" })

  # Routes to CREATE photos
  get("/photos/new", { :controller => "photos", :action => "new_form" })
  get("/create_photo", { :controller => "photos", :action => "create_row" })

  # Routes to READ photos
  get("/photos",           { :controller => "photos", :action => "index" })
  get("/photos/:some_id",       { :controller => "photos", :action => "show" })

  # Routes to UPDATE photos
  get("/photos/:some_id/edit", { :controller => "photos", :action => "edit_form" })

  # Route to DELETE photos
  get("/delete_photo/:some_id", { :controller => "photos", :action => "destroy_row" })
end
