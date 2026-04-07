class EmployeesController < ApplicationController

  def index
    render json: Employee.all
  end

  def show
    employee = Employee.find(params[:id])
    render json: employee
  end

  def create
    employee = Employee.create!(employee_params)
    render json: employee, status: :created
  end

  def update
    employee = Employee.find(params[:id])
    employee.update!(employee_params)
    render json: employee
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    head :no_content
  end

  def salary
    emp = Employee.find(params[:id])

    deduction =
        case emp.country
        when "India" then emp.salary * 0.1
        when "United States" then emp.salary * 0.12
        else 0
        end

    render json: {
        gross: emp.salary,
        deduction: deduction,
        net: (emp.salary - deduction).to_i
    }
  end

  private

  def employee_params
    params.permit(:full_name, :job_title, :country, :salary)
  end

end