require 'rails_helper'

RSpec.describe "Employees API", type: :request do
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
end