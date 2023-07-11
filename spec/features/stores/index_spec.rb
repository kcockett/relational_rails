require "rails_helper"

describe "The stores pages" do
  before :each do
    @store1 = Store.create!(store_name: "Moab Tour Company", address1: "427 N. Main Street", address2: " ", city: "Moab", state: "UT", zip_code: "84532", currently_hiring: false, manager_name: "Brandon Daley", created_at: "2003-03-15 08:20:00+00", updated_at: Time.now) 
    @store2 = Store.create!(store_name: "Estes Park ATV Rentals", address1: "222 East Elkhorn Ave", address2: " ", city: "Estes Park", state: "CO", zip_code: "80517", currently_hiring: true, manager_name: "Andy Hitch", created_at: "2001-09-25 18:20:00+00", updated_at: Time.now)
    @vehicle1 = Vehicle.create!(model_year: 2019, make: "Yamaha", model: "WR250F", mileage: 0, repairs_needed: false, store_id: @store1.id, seating: 1, last_service_date: "2023-02-21 12:30:00+00", engine_hours: 150)
    @vehicle2 = Vehicle.create!(model_year: 2022, make: "CFMoto", model: "CForce 600 Touring", mileage: 425, repairs_needed: true, store_id: @store1.id, seating: 2, last_service_date: "2003-02-10 18:20:00+00", engine_hours: 0)
    @vehicle3 = Vehicle.create!(model_year: 2016, make: "Polaris", model: "Ace 900 SE", mileage: 525, repairs_needed: true, store_id: @store2.id, seating: 1, last_service_date: "2023-05-25 12:00:00+00", engine_hours: 0)
    @vehicle4 = Vehicle.create!(model_year: 2023, make: "Kawasaki", model: "KRX 1000 SE", mileage: 120, repairs_needed: true, store_id: @store2.id, seating: 4, last_service_date: "2023-07-01 12:00:00+00", engine_hours: 10)
    @vehicle5 = Vehicle.create!(model_year: 2024, make: "Can-Am", model: "Maverick X3 Turbo", mileage: 10, repairs_needed: true, store_id: @store2.id, seating: 2, last_service_date: "2023-06-25 12:00:00+00", engine_hours: 1)
  end
  describe "When I visit '/stores'" do
    it "I see the name of each parent record in the system" do
      visit "/stores"
      expect(page).to have_content(@store1.store_name)
      expect(page).to have_content(@store2.store_name)
    end
    it "US6 - I see that records are ordered by most recently created first and next to each of the records I see when it was created" do
      visit "/stores"

      expect(page).to have_content(@store1.created_at)
      expect(page).to have_content(@store2.created_at)
      expect(page.text.index(@store2.store_name)).to be > page.text.index(@store1.store_name)
    end
    it "US8 - I see a link at the top of the page that takes me to the vehicles index" do
      visit "/stores" 

      expect(page).to have_link("All Vehicles", :href=>"/vehicles")
    end
    it "US9 - I see a link at the top of the page that takes me to the stores Index" do
      visit "/stores" 
      
      expect(page).to have_link("All Stores", :href=>"/stores")
    end
    it "US11 - I see a link to create a new store record, 'New Store" do
      visit "/stores"
      
      expect(page).to have_link("New Store", :href=>"/stores/new")
    end
    it "US11 - When I click this link, I am taken to '/store/new' where I see a form for a new store record" do
      visit "/stores"
      click_link('New Store')
      expect(current_path).to eq('/stores/new')
      expect(page).to have_css('#newstoreform')
    end
    it "US11 - When I fill out the form with a new store's attributes: And I click the button 'Create store' to submit the form, then a `POST` request is sent to the '/stores' route, a new store record is created, and I am redirected to the store Index page where I see the new store displayed." do
      visit "/stores/new"
      within('#newstoreform') do
        fill_in "store[store_name]", with: "New Store"
        fill_in "store[address1]", with: "123 Any Street"
        fill_in "store[address2]", with: "Suite 110"
        fill_in "store[city]", with: "Anytown"
        fill_in "store[state]", with: "CO"
        fill_in "store[zip_code]", with: "80000"
        page.choose('true')
        fill_in "store[manager_name]", with: "Joe Smith"
      end
      click_button("Submit")
      
      expect(current_path).to eq("/stores/")
    end
    it "US17 - Next to every store, I see a link to edit that store's info" do
      visit "/stores/"

      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('edit')
        end
      end
    end
    it "US17 - When I click the link I should be taken to that store's edit page where I can update its information" do
      visit "/stores/"
      first('a', text: 'edit').click
      expect(current_path).to eq("/stores/#{@store1.id}/edit")
    end
    it "US22 - Next to every store, I see a link to delete that store" do
      visit "/stores/"

      all('h3').each do |h3|
        within(h3) do
          expect(page).to have_link('delete')
        end
      end
    end
    it "US22 - When I click the link I am returned to the store Index Page where I no longer see that store" do
      visit "/stores/"
      first('a', text: 'delete').click
      expect(current_path).to eq("/stores")
      expect(page).to_not have_content("#{@store1.store_name}")
      expect(page).to have_content("#{@store2.store_name}")
    end
    it "EX1 - Then I see a link to sort stores by the number of `vechicles` they have" do
      visit "/stores/"

      expect(page).to have_link('sort by vehicle count')
    end
    it "EX1 - When I click on the link I'm taken back to the store Index Page where I see all of the stores in order of their count of `vechicles` (highest to lowest) And, I see the number of children next to each store name" do
      visit "/stores/"
      
      expect(page.text.index(@store1.store_name)).to be < page.text.index(@store2.store_name)
      click_link('sort by vehicle count')
      expect(page.text.index(@store1.store_name)).to be > page.text.index(@store2.store_name)

    end
  end

end