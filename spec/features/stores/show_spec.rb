require "rails_helper"

describe "The stores pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2001-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
  end

  describe "When I visit '/stores/:id" do
    it "US2 - Then I see the store with that id including the store's attributes" do
      visit "/stores/#{@store1.id}"
      expect(page).to have_content(@store1.store_name)
      expect(page).to have_content(@store1.address1)
      expect(page).to have_content(@store1.address2)
      expect(page).to have_content(@store1.city)
      expect(page).to have_content(@store1.state)
      expect(page).to have_content(@store1.zip_code)
      expect(page).to have_content(@store1.manager_name)
    end
    it "US7 - I see a count of the number of children associated with this parent" do
      visit "/stores/#{@store1.id}"
      expect(page).to have_content("Vehicles in store: #{Vehicle.where(store_id: @store1.id).count}")
      
      visit "/stores/#{@store2.id}"
      expect(page).to have_content("Vehicles in store: #{Vehicle.where(store_id: @store2.id).count}")
    end
    it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
      visit "/stores/#{@store1.id}"
      
      expect(page).to have_link("All Vehicles", :href=>"/vehicles")
    end
    it "US9 - I see a link at the top of the page that takes me to the stores Index" do
      visit "/stores/#{@store1.id}"
      
      expect(page).to have_link("All Stores", :href=>"/stores")
    end
    it "US10 - I see a link to take me to that stores's vehicles page" do
      visit "/stores/#{@store1.id}"
      
      expect(page).to have_link("Vehicles at this store", :href=>"/stores/#{@store1.id}/vehicles")
    end
    it "US12 - I see a link to update the store 'Update Store'" do
      visit "/stores/#{@store1.id}"
      
      expect(page).to have_link("Update Store", :href=>"/stores/#{@store1.id}/edit")
    end
    it "US12 - When I click the link 'Update Store' then I am taken to '/stores/:id/edit' where I see a form to edit the stores's attributes" do
      visit "/stores/#{@store1.id}"
      click_link('Update Store')

      expect(current_path).to eq("/stores/#{@store1.id}/edit")
      expect(page).to have_css('#updatestoreform')
    end
    it "US12 - When I fill out the form with updated information and I click the button to submit the form then a `PATCH` request is sent to '/stores/:id', the store's info is updated, and I am redirected to the store's Show page where I see the store's updated info" do
      visit "/stores/#{@store1.id}/edit"
      within('#updatestoreform') do
        fill_in "store[store_name]", with: "Moab Touring Co"
        fill_in "store[address1]", with: "123 Any Street"
        fill_in "store[address2]", with: "Suite 110"
        fill_in "store[city]", with: "Anytown"
        fill_in "store[state]", with: "CO"
        fill_in "store[zip_code]", with: "80000"
        page.choose('true')
        fill_in "store[manager_name]", with: "Joe Smith"
      end
      click_button("Submit")
      
      expect(current_path).to eq("/stores/#{@store1.id}")
      expect(page).to have_content("Moab Touring Co")
      expect(page).to have_content("123 Any Street")
      expect(page).to have_content("Suite 110")
      expect(page).to have_content("Anytown")
      expect(page).to have_content("80000")
      expect(page).to have_content("Joe Smith")
    end
    it "US19 - Then I see a link to delete the store" do
      visit "/stores/#{@store1.id}"
      
      expect(page).to have_link("Delete Store", :href=>"/stores/#{@store1.id}")
    end
    it "US19 - When I click the link 'Delete Store' then a 'DELETE' request is sent to '/stores/:id', the store is deleted, and all child records are deleted and I am redirected to the store index page where I no longer see this store" do
      visit "/stores/#{@store1.id}"
      click_link('Delete Store')
      
      expect(current_path).to eq("/stores")
      expect(page).to_not have_content("#{@store1.store_name}")
      
      visit "/vehicles/"
      expect(page).to_not have_content("#{@vehicle1.make}")
      expect(page).to_not have_content("#{@vehicle2.make}")
      expect(page).to have_content("#{@vehicle3.make}")
    end
  end
end
