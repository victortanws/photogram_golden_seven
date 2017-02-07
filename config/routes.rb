Rails.application.routes.draw do

  get("/", { :controller => "photos", :action => "index" })

  # Routes to CREATE photos
  get("/photos/new", { :controller => "photos", :action => "new_form" })

  # Routes to READ photos
  get("/photos",           { :controller => "photos", :action => "index" })
  get("/photos/:some_id",       { :controller => "photos", :action => "show" })

end
