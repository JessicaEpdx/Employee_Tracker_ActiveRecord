require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('./lib/division')
require('./lib/employee')
require('./lib/project')
also_reload('lib/**/*.rb')

get('/') do
  @all_divisions = Division.all()
  @all_employees = Employee.all()
  @all_projects = Project.all()
  erb(:index)
end

post('/') do
  Division.create({:name => params.fetch("name")})
  @all_divisions = Division.all()
  @all_employees = Employee.all()
  @all_projects = Project.all()
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
  @division.delete
  @all_divisions = Division.all
  @all_employees = Employee.all
  @all_projects = Project.all
  erb(:index)
end

patch('/division/:id/employee') do
  @division = Division.find(params.fetch("id").to_i)
  @division.employees.new({:name => params.fetch("employee_name")})
  @division.save()
  erb(:division)
end

get('/employee/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  erb(:employee)
end


delete('/success') do
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.delete()
  erb(:success)
end


get('/project/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @all_employees = Employee.all()
  @all_divisions = Division.all
  @all_employees = Employee.all
  @all_projects = Project.all
  erb(:project)
end

patch('/project/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @project.employees.new({:name => params.fetch("employee")})
  @project.save()
  @all_employees = Employee.all()
  erb(:project)
end

delete('/project/:id') do
  @project = Project.find(params.fetch("id").to_i)
  @employee = Employee.find(params.fetch("employee_id").to_i)
  @employee.update({:project_id => nil})
  @employee.save()
  @all_employees = Employee.all()
  erb(:project)
end

patch('/employee/:id') do
  @employee = Employee.find(params.fetch("id").to_i)
  @employee.update({:name => params.fetch("name")})
  erb(:employee)
end

delete('/success/project') do
  @project = Project.find(params.fetch("id"))
  @project.delete()
  erb(:success)
end
