require 'rails_helper'

RSpec.describe "Employees API", type: :request do

  it "creates employee" do
    post "/employees", params: {
      full_name: "Pavan",
      job_title: "Engineer",
      country: "India",
      salary: 50000
    }

    expect(response).to have_http_status(201)
  end

  it "gets all employees" do
    Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)

    get "/employees"

    expect(response).to have_http_status(200)
  end

  it "gets one employee" do
    emp = Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)

    get "/employees/#{emp.id}"

    expect(response).to have_http_status(200)
  end

  it "updates employee" do
    emp = Employee.create!(full_name: "Old", job_title: "Dev", country: "India", salary: 1000)

    put "/employees/#{emp.id}", params: { full_name: "New" }

    expect(response).to have_http_status(200)
  end

  it "deletes employee" do
    emp = Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)

    delete "/employees/#{emp.id}"

    expect(response).to have_http_status(204)
  end

  it "calculates salary for India" do
    emp = Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)

    get "/employees/#{emp.id}/salary"

    json = JSON.parse(response.body)
    expect(json["net"]).to eq(900)
  end

  it "returns metrics by country" do
    Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 1000)
    Employee.create!(full_name: "B", job_title: "Dev", country: "India", salary: 2000)

    get "/metrics/country?name=India"

    expect(response).to have_http_status(200)
  end

end