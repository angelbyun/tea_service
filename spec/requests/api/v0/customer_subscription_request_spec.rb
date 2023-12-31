require 'rails_helper'

RSpec.describe "Customer Subscription API" do
  describe "Customer Subscription" do
    before(:each) do
      @cust_1 = Customer.create!(first_name: "Angel", last_name: "Byun", email: "angel123@email.com", address: "123 Littleton Way, Littleton, CO 80123")
      @cust_2 = Customer.create!(first_name: "Scott", last_name: "Le", email: "scottlovestea@email.com", address: "987 Main St, Aurora, CO, 80016")

      @tea_1 = Tea.create!(title: "Black", description: "Caffeinated, great hot, substitute for coffee, great with creamer of choice", temperature: "Hot", brew_time: "8-10 minutes")
      @tea_2 = Tea.create!(title: "Green", description: "Caffeinated, great hot, substitute for coffee, great as is or with honey", temperature: "Hot", brew_time: "8-10 minutes")
      @tea_3 = Tea.create!(title: "Hibiscus", description: "Uncaffeinated, best served cold, great tea when added with a splash of fruit juice", temperature: "Cold", brew_time: "4-6 minutes")
      @tea_4 = Tea.create!(title: "Butterfly Pea", description: "Uncaffeinated, best served cold, great for your immune system, watch it change color to purple when lemonade is added", temperature: "Cold", brew_time: "6-8 minutes")
      @tea_5 = Tea.create!(title: "Chamomile", description: "Uncaffeinated, great hot, great when stressed or unable to sleep with some honey and lemon", temperature: "Hot", brew_time: "8-9 minutes")
    end

    it "displays all customer subscriptions" do
      subscription_1 = Subscription.create!(title: "Hibiscus", price: "12.00", status: "Active", frequency: "Monthly", customer_id: @cust_1.id, tea_id: @tea_3.id)
      subscription_2 = Subscription.create!(title: "Butterfly Pea", price: "15.00", status: "Active", frequency: "Yearly", customer_id: @cust_1.id, tea_id: @tea_4.id)
      subscription_3 = Subscription.create!(title: "Black", price: "7.00", status: "Canceled", frequency: "Monthly", customer_id: @cust_1.id, tea_id: @tea_1.id)
      subscription_4 = Subscription.create!(title: "Chamomile", price: "5.00", status: "Active", frequency: "Monthly", customer_id: @cust_1.id, tea_id: @tea_5.id)

      get "/api/v0/subscriptions", params: { id: @cust_1.id }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      subscription_data = JSON.parse(response.body, symbolize_names: true)

      expect(subscription_data).to be_a(Hash)
      expect(subscription_data).to have_key(:data)
      expect(subscription_data[:data]).to be_an(Array)
      

      subscription_data[:data].each do |sub|
        expect(sub).to have_key(:id)
        expect(sub).to have_key(:type)
        expect(sub[:type]).to eq("subscription")
        expect(sub).to have_key(:attributes)
        expect(sub[:attributes]).to have_key(:title)
        expect(sub[:attributes]).to have_key(:price)
        expect(sub[:attributes]).to have_key(:status)
        expect(sub[:attributes]).to have_key(:frequency)
        expect(sub[:attributes]).to have_key(:customer_id)
        expect(sub[:attributes]).to have_key(:tea_id)
      end
    end
  end
end