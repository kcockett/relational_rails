require "rails_helper"
describe "The vehicles pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2008-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end
  describe "As a visitor, when I visit '/vehicles/:id'" do
    it "US4 - Then I see the vehicle with that id including the vehicle's attributes" do
      visit "/vehicles/#{@vehicle1.id}"

      expect(page).to have_content(@vehicle1.model_year)
      expect(page).to have_content(@vehicle1.make)
      expect(page).to have_content(@vehicle1.model)
      expect(page).to have_content(@vehicle1.mileage)
      expect(page).to have_content(@vehicle1.store_id)
      expect(page).to have_content(@vehicle1.seating)
      expect(page).to have_content(@vehicle1.last_service_date)
      expect(page).to have_content(@vehicle1.engine_hours)
    end
    it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
      visit "/vehicles/#{@vehicle1.id}"

      expect(page).to have_link("All Vehicles", :href=>"/vehicles")
    end
    it "US9 - I see a link at the top of the page that takes me to the stores Index" do
      visit "/vehicles/#{@vehicle1.id}"
      
      expect(page).to have_link("All Stores", :href=>"/stores")
    end
    it "US14 - Then I see a link to update that Vehicle 'Update Vehicle'" do
      visit "/vehicles/#{@vehicle1.id}"
      expect(page).to have_link("Update Vehicle", :href=>"/vehicles/#{@vehicle1.id}/edit")
    end

    it "US14 - When I click the link I am taken to '/vehicles/:id/edit' where I see a form to edit the vehicle's attributes" do
      visit "/vehicles/#{@vehicle1.id}"
      click_link('Update Vehicle')

      expect(current_path).to eq("/vehicles/#{@vehicle1.id}/edit")
      expect(page).to have_css('#updatevehicleform')
    end

    it "US14 - When I click the button to submit the form 'Update Vehicle' then a `PATCH` request is sent to '/vehicles/:id',the vehicle's data is updated, and I am redirected to the vehicle Show page where I see the vehicle's updated information" do
      visit "/vehicles/#{@vehicle1.id}/edit"
      within('#updatevehicleform') do
        fill_in "vehicle[model_year]", with: "1972"
        fill_in "vehicle[make]", with: "Kawasaki"
        fill_in "vehicle[model]", with: "KX110"
        fill_in "vehicle[mileage]", with: "17652"
        fill_in "vehicle[seating]", with: "1"
        fill_in "vehicle[last_service_date]", with: "#{Time.now}"
        fill_in "vehicle[engine_hours]", with: "704"
        page.choose('true')
      end
      click_button("Submit")
      
      expect(current_path).to eq("/vehicles/#{@vehicle1.id}")
      expect(page).to have_content("1972")
      expect(page).to have_content("Kawasaki")
      expect(page).to have_content("KX110")
      expect(page).to have_content("17652")
      expect(page).to have_content("704")
    end
    it "US20 - Then I see a link to delete the child 'Delete Vehicle" do
      visit "/vehicles/#{@vehicle1.id}"
      
      expect(page).to have_link("Delete Vehicle", :href=>"/vehicles/#{@vehicle1.id}")
    end
    it "US20 - When I click the link then a 'DELETE' request is sent to '/vehicles/:id', the vehicle is deleted, and I am redirected to the vehicle index page where I no longer see this vehicle" do
      visit "/vehicles/#{@vehicle1.id}"
      click_link('Delete Vehicle')
      
      expect(current_path).to eq("/vehicles")
      expect(page).to_not have_content("#{@vehicle1.make}")
    end
  end
end