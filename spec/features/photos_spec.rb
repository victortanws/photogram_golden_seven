require "rails_helper"

feature "Home page" do
  scenario "is the photos index page", points: 0, hint:  "Should always pass since starting point takes care of this" do
    visit "/"

    expect(page).to have_selector("h1", text: "List of Photos")
  end
end

feature "Photo details page" do
  scenario "has a functional RCAV", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page)
  end

  scenario "displays caption", points: 3 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_content(photo.caption)
  end

  scenario "displays image", points: 5 do
    photo = create(:photo)

    visit "/photos/#{photo.id}"

    expect(page).to have_css("img[src*='#{photo.source}']")
  end
end

feature "New photo page" do
  scenario "has a functional RCAV", points: 1 do
    visit "/photos/new"

    expect(page)
  end

  scenario "has a form", points: 1 do
    visit "/photos/new"

    expect(page).to have_selector("form", count: 1)
  end

  scenario "has two inputs", points: 1 do
    visit "/photos/new"

    expect(page).to have_selector("input", count: 2)
  end

  scenario "has a label for 'Caption'", points: 1 do
    visit "/photos/new"

    expect(page).to have_selector("label", text: "Caption")
  end

  scenario "has a label for 'Image URL'", points: 1 do
    visit "/photos/new"

    expect(page).to have_selector("label", text: "Image URL")
  end

  scenario "has a button to 'Create Photo'", points: 1 do
    visit "/photos/new"

    expect(page).to have_selector("button", text: "Create Photo")
  end

  scenario "creates a photo when submitted", points: 3 do
    initial_number_of_photos = Photo.count

    visit "/photos/new"
    click_on "Create Photo"

    final_number_of_photos = Photo.count
    expect(final_number_of_photos).to eq(initial_number_of_photos + 1)
  end

  scenario "saves the caption when submitted", points: 2, hint: "Be sure your label is 'Caption' and is tied to the correct input through its `for=\"\"` attribute" do
    test_caption = "Photogram test caption, added at time #{Time.now}."

    visit "/photos/new"
    fill_in("Caption", with: test_caption)
    click_on "Create Photo"

    last_photo = Photo.order(created_at: :asc).last
    expect(last_photo.caption).to eq(test_caption)
  end

  scenario "saves the image URL when submitted", points: 2, hint: "Be sure your label is 'Image URL' and is tied to the correct input through its `for=\"\"` attribute" do
    test_source = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Pluto-01_Stern_03_Pluto_Color_TXT.jpg/240px-Pluto-01_Stern_03_Pluto_Color_TXT.jpg"

    visit "/photos/new"
    fill_in("Image URL", with: test_source)
    click_on "Create Photo"

    last_photo = Photo.order(created_at: :asc).last
    expect(last_photo.source).to eq(test_source)
  end
end

feature "Delete photo" do
  scenario "removes a row from the table", points: 5 do
    photo = create(:photo)

    visit "/delete_photo/#{photo.id}"

    expect(Photo.exists?(photo.id)).to be false
  end

  scenario "redirects user to the index page", points: 3 do
    photo = create(:photo)

    visit "/delete_photo/#{photo.id}"

    expect(page).to have_current_path("/photos")
  end
end

feature "Edit photo page" do
  scenario "has a functional RCAV", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page)
  end

  scenario "has a form", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("form", count: 1)
  end

  scenario "has two inputs", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("input", count: 2)
  end

  scenario "has a label for 'Caption'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("label", text: "Caption")
  end

  scenario "has a label for 'Image URL'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("label", text: "Image URL")
  end

  scenario "has a button to 'Update Photo'", points: 1 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("button", text: "Update Photo")
  end

  scenario "has caption prepopulated", points: 3 do
    photo = create(:photo, caption: "Old caption")

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("input[value='Old caption']")
  end

  scenario "has image source prepopulated", points: 3 do
    photo = create(:photo, source: "http://old.image/source.jpg")

    visit "/photos/#{photo.id}/edit"

    expect(page).to have_selector("input[value='http://old.image/source.jpg']")
  end

  scenario "updates caption when submitted", points: 5, hint: "Be sure your label is 'Caption' and is tied to the correct input through its `for=\"\"` attribute" do
    photo = create(:photo, caption: "Old caption")
    test_caption = "New caption, added at #{Time.now}"

    visit "/photos/#{photo.id}/edit"
    fill_in("Caption", with: test_caption)
    click_on "Update Photo"

    photo_as_revised = Photo.find(photo.id)

    expect(photo_as_revised.caption).to eq(test_caption)
  end

  scenario "updates image source when submitted", points: 5, hint: "Be sure your label is 'Image URL' and is tied to the correct input through its `for=\"\"` attribute" do
    photo = create(:photo, source: "http://old.image/source.jpg")
    test_source = "http://new.image/source_#{Time.now.to_i}.jpg"

    visit "/photos/#{photo.id}/edit"
    fill_in("Image URL", with: test_source)
    click_on "Update Photo"

    photo_as_revised = Photo.find(photo.id)

    expect(photo_as_revised.source).to eq(test_source)
  end

  scenario "redirects user to the show page", points: 3 do
    photo = create(:photo)

    visit "/photos/#{photo.id}/edit"
    click_on "Update Photo"

    expect(page).to have_current_path("/photos/#{photo.id}")
  end
end
