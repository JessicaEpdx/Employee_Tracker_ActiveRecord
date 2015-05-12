class Employee < ActiveRecord::Base
  belongs_to(:division)
  belongs_to(:projects)
end
