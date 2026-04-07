class MetricsController < ApplicationController
  def country
    emps = Employee.where(country: params[:name])

    render json: {
      min: emps.minimum(:salary),
      max: emps.maximum(:salary),
      avg: emps.average(:salary)
    }
  end

  def job
    emps = Employee.where(job_title: params[:title])

    render json: {
      avg: emps.average(:salary)
    }
  end
end