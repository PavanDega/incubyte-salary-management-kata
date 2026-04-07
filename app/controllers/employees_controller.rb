class EmployeesController < ApplicationController
  def create
    employee = Employee.create!(employee_params)
    render json: employee, status: :created
  end

  private

  def employee_params
    params.permit(:full_name, :job_title, :country, :salary)
  end
end