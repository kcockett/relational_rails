require "rails_helper"

describe "The stores pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2001-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end
  
  describe "When I visit '/stores/:id/vehicles" do
    it "Then I see each vehicle that is associated with that store with each vehicle's attributes" do
      visit "/stores/#{@store1.id}/vehicles"
      
      expect(page).to have_content(@vehicle1.model_year)
      expect(page).to have_content(@vehicle2.model_year)
      expect(page).to have_content(@vehicle1.make)
      expect(page).to have_content(@vehicle1.model)
      expect(page).to have_content(@vehicle2.model)
      expect(page).to have_content(@vehicle1.mileage)
      expect(page).to have_content(@vehicle2.mileage)
      
      expect(page).to_not have_content(@vehicle3.model_year)
      expect(page).to_not have_content(@vehicle3.make)
      expect(page).to_not have_content(@vehicle3.model)
      expect(page).to_not have_content(@vehicle3.mileage)
      
    end
    it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
      visit "/stores/#{@store1.id}/vehicles"
      
      expect(page).to have_link("All Vehicles", :href=>"/vehicles")
    end
    it "US9 - I see a link at the top of the page that takes me to the stores Index" do
      visit "/stores/#{@store1.id}/vehicles"
      
      expect(page).to have_link("All Stores", :href=>"/stores")
    end
    it "US13 - Then I see a link to add a new vehicle for that store 'Create Vehicle'" do
      visit "/stores/#{@store1.id}/vehicles"
      
      expect(page).to have_link("Create Vehicle", :href=>"/stores/#{@store1.id}/vehicles/new")
    end
    it "US13 - When I click the 'Create Vehicle' link I am taken to '/stores/:store_id/vehicles/new' where I see a form to add a new adoptable vehicle" do
      visit "/stores/#{@store1.id}/vehicles"
      click_link('Create Vehicle')
      
      expect(current_path).to eq("/stores/#{@store1.id}/vehicles/new")
      expect(page).to have_css('#newvehicleform')
    end
    it "US13 - When I fill in the form with the vehicle's attributes and I click the button 'Create Vehicle' then a `POST` request is sent to '/stores/:store_id/vehicles', a new vehicle object/row is created for that store, and I am redirected to the store vehicles Index page where I can see the new vehicle listed" do
      visit "/stores/#{@store1.id}/vehicles/new"
      
      within('#newvehicleform') do
        fill_in "vehicle[model_year]", with: "2024"
        fill_in "vehicle[make]", with: "CFMoto"
        fill_in "vehicle[model]", with: "CForce 1000"
        fill_in "vehicle[mileage]", with: "5"
        fill_in "vehicle[seating]", with: "2"
        fill_in "vehicle[last_service_date]", with: "#{Time.now}"
        fill_in "vehicle[engine_hours]", with: "1"
      end
      click_button("Submit")
      
      expect(current_path).to eq("/stores/#{@store1.id}/vehicles")
      expect(page).to have_content("2024")
      expect(page).to have_content("CForce 1000")
    end
    it "US16 - Then I see a link to sort children in alphabetical order" do
      visit "/stores/#{@store1.id}/vehicles"
      
      expect(page).to have_link("Sort Vehicles")
      expect(page.text.index(@vehicle1.make)).to be < page.text.index(@vehicle2.make)
    end
    it "US16 - When I click on the link I'm taken back to the store's vehicle Index Page where I see all of the store's vehicles in alphabetical order" do
      visit "/stores/#{@store1.id}/vehicles"
      click_link('Sort Vehicles')
      
      expect(page.text.index(@vehicle2.make)).to be < page.text.index(@vehicle1.make)
    end
    it "US18 - Next to every vehicle, I see a link to edit that vehicle's info" do
      visit "/stores/#{@store1.id}/vehicles"
      
      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('edit')
        end
      end
    end
    it "US18 - When I click the link I should be taken to that `vehicles` edit page where I can update its information" do
      visit "/stores/#{@store1.id}/vehicles"
      first('a', text: 'edit').click
      
      expect(current_path).to eq("/vehicles/#{@vehicle1.id}/edit")
    end
    it "US21 - I see a form that allows me to input a number value" do
      visit "/stores/#{@store1.id}/vehicles"
      expect(page).to have_field("seating_filter")
    end
    it "US21 - When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'. Then I am brought back to the current index page with only the records that meet that threshold shown." do
      visit "/stores/#{@store1.id}/vehicles"
      within('#seating_filter_form') {fill_in "seating_filter", with: "2"}
      click_button("Filter")
      
      expect(current_path).to eq("/stores/#{@store1.id}/vehicles")
      expect(page).to_not have_content("#{@vehicle1.make}")
      expect(page).to have_content("#{@vehicle2.make}")
    end
    it "US23 - Next to every vehicle, I see a link to delete that vehicle" do
      visit "/vehicles"

      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('delete')
        end
      end
    end
    it "US23 - When I click the link I should be taken to the `vehicles` index page where I no longer see that vehicle" do
      visit "/vehicles"
      first('a', text: 'delete').click
      expect(current_path).to eq("/vehicles")
      expect(page).to_not have_content("#{@vehicle2.make}")
      expect(page).to have_content("#{@vehicle3.make}")
    end
  end
end