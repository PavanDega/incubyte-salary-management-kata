require 'rails_helper'

RSpec.describe "Employees API", type: :request do

  # CREATE
  describe "POST /employees" do
    it "creates an employee" do
      post "/employees", params: {
        full_name: "Pavan",
        job_title: "Engineer",
        country: "India",
        salary: 50000
      }

      expect(response).to have_http_status(201)
    end
  end

  # READ ALL
  describe "GET /employees" do
    it "returns all employees" do
      Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)
      Employee.create!(full_name: "B", job_title: "QA", country: "US", salary: 2000)

      get "/employees"

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
    end
  end

  # READ ONE
  describe "GET /employees/:id" do
    it "returns one employee" do
      emp = Employee.create!(full_name: "Pavan", job_title: "Dev", country: "India", salary: 1000)

      get "/employees/#{emp.id}"

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)
      expect(json["id"]).to eq(emp.id)
    end
  end

  # UPDATE
  describe "PUT /employees/:id" do
    it "updates employee" do
      emp = Employee.create!(full_name: "Old", job_title: "Dev", country: "India", salary: 1000)

      put "/employees/#{emp.id}", params: { full_name: "New" }

      expect(response).to have_http_status(200)

      emp.reload
      expect(emp.full_name).to eq("New")
    end
  end

  # DELETE
  describe "DELETE /employees/:id" do
    it "deletes employee" do
      emp = Employee.create!(full_name: "Pavan", job_title: "Dev", country: "India", salary: 1000)

      delete "/employees/#{emp.id}"

      expect(response).to have_http_status(204)
    end
  end

end