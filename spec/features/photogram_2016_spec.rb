require "rails_helper"

# / && /PHOTOS
feature "Home page (same as /photos)" do
  scenario "Home page has an h1 tag with text 'List of Photos' (should always pass since initial repo takes care of this)", points: 1 do
    visit "/"
    expect(page).to have_selector("h1", text: "List of Photos")
  end
end

# /PHOTOS/:ID
feature "Photo details page (/photos/:id)" do
  photo = FactoryGirl.create(:photo)

  scenario "Photo details page (/photos/:id) exists (RCAV set)", points: 1 do
    visit "/photos/#{photo.id}"
    expect(page)
  end

  scenario "Photo details page (/photos/:id) displays photo", points: 1 do
    visit "/photos/#{photo.id}"
    expect(page).to have_css("img[src*='#{photo.source}']")
  end

  scenario "Photo details page (/photos/:id) displays caption", points: 1 do
    visit "/photos/#{photo.id}"
    expect(page).to have_content("#{photo.caption}")
  end
end

# /PHOTOS/NEW && /CREATE_PHOTO
feature "New photo page (/photos/new)" do
  scenario "New photo page (/photos/new) exists (RCAV set)", points: 1 do
    visit "/photos/new"
    expect(page)
  end

  scenario "New photo page (/photos/new) has one form with two input elements with agreed-upon input labels", points: 1 do
    visit "/photos/new"
    expect(page).to have_selector("form", count: 1)
    expect(page).to have_selector("input", count: 2)
    expect(page).to have_selector("label", text: "Caption:")
    expect(page).to have_selector("label", text: "Image URL:")
  end

  scenario "New photo page (/photos/new) works", points: 1 do
    visit "/photos/new"
    initial_number_of_photos = Photo.count

    # Submit form
    test_source = "http://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Fire_breathing_2_Luc_Viatour.jpg/1280px-Fire_breathing_2_Luc_Viatour.jpg"
    test_caption = "Photogram test caption, added at time #{Time.now.to_i}"
    fill_in("Image URL:", with: test_source)
    fill_in("Caption:", with: test_caption)
    click_on "Create Photo"

    # Check that submitting form worked
    final_number_of_photos = Photo.count
    last_photo = Photo.last
    expect(initial_number_of_photos + 1).to eq(final_number_of_photos)
    expect(last_photo.source).to eq(test_source)
    expect(last_photo.caption).to eq(test_caption)
  end
end

# /PHOTOS/DELETE_PHOTO/:ID
feature "Delete photo (/photos/delete_photo/:id)" do
  photo = FactoryGirl.create(:photo, source: "www.google.com", caption: "not a real photo, added at time #{Time.now.to_i}")

  # Check that photo removed
  scenario "Delete photo (/photos/delete_photo/:id) works", points: 1 do
    initial_number_of_photos = Photo.count
    visit "/delete_photo/#{photo.id}"
    final_number_of_photos = Photo.count
    photo_still_present = Photo.exists?(photo.id)
    expect(initial_number_of_photos - 1).to eq(final_number_of_photos)
    expect(photo_still_present).to eq(false)
  end

  # Check that sent back to index page
  scenario "Delete photo (/photos/delete_photo/:id) returns user to index page", points: 1 do
    visit "/delete_photo/#{photo.id}"
    expect(page).to have_selector("h1", text: "List of Photos")
  end
end

# /PHOTOS/:ID/EDIT && /UPDATE_PHOTO/:ID
feature "Edit photo page (/photos/:id/edit)" do
  photo = FactoryGirl.create(:photo)

  scenario "Edit photo page (/photos/:id/edit) exists (RCAV set)", points: 1 do
    visit "/photos/#{photo.id}/edit"
    expect(page)
  end

  scenario "Edit photo page (/photos/:id/edit) has one form with two input elements with agreed-upon input labels", points: 1 do
    visit "/photos/#{photo.id}/edit"
    expect(page).to have_selector("form", count: 1)
    expect(page).to have_selector("input", count: 2)
    expect(page).to have_selector("label", text: "Caption:")
    expect(page).to have_selector("label", text: "Image URL:")
  end

  scenario "Edit photo page (/photos/:id/edit) has photo caption & source prepopulated in input fields", points: 1 do
    visit "/photos/#{photo.id}/edit"
    expect(page).to have_selector("input[value='#{photo.caption}']")
    expect(page).to have_selector("input[value='#{photo.source}']")
  end

  scenario "Edit photo page (/photos/:id/edit) exists (RCAV set)", points: 1 do
    visit "/photos/#{photo.id}/edit"
    initial_number_of_photos = Photo.count

    # Submit form
    test_caption = "Photogram test caption, added at time #{Time.now.to_i}"
    test_source = "http://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Fire_breathing_2_Luc_Viatour.jpg/1280px-Fire_breathing_2_Luc_Viatour.jpg"
    fill_in("Image URL:", with: test_source)
    fill_in("Caption:", with: test_caption)
    click_on "Update Photo"
    final_number_of_photos = Photo.count
    photo_as_revised = Photo.last

    # Photo successfully edited
    expect(photo_as_revised.caption).to eq(test_caption)
    expect(photo_as_revised.source).to eq(test_source)
    expect(initial_number_of_photos).to eq(final_number_of_photos)
  end

  scenario "Edit photo page (/photos/:id/edit) redirects to photo details page", points: 1 do
    visit "/photos/#{photo.id}/edit"
    click_on "Update Photo"
    expect(page).to have_css("img[src*='#{photo.source}']")
    expect(page).to have_content("#{photo.caption}")
  end
end
