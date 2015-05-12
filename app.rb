require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/division')
require('./lib/employee')
also_reload('lib/**/*.rb')
require('pg')

get('/') do
  @divisions = Division.all()
  @all_employees = Employee.all()
  erb(:index)
end

post('/') do
  Division.create({:name => params.fetch("name")})
  @divisions = Division.all()
  @all_employees = Employee.all()
  erb(:index)
end

get('/division/:id') do
  @division = Division.find(params.fetch("id").to_i)
  erb(:division)
end

patch('/division/:id') do
  @division = Division.find(params.fetch("id").to_i)
  @division.update(:name => params.fetch("name"))
  @division.save
  erb(:division)
end

delete('/') do
  @division = Division.find(params.fetch("id").to_i)
  @division.delete()
  @divisions = Division.all()
  @all_employees = Employee.all()
  erb(:index)
end

patch('/division/:id/employee') do
  @division = Division.find(params.fetch("id").to_i)
  @division.employees.new({:name => params.fetch("employee_name")})
  @division.save()
  erb(:division)
end
