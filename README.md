# Generic Stimulus Controller for Nested Attributes

## Setting Up Project

Change directories into your current project, which may be named as such:
```shell
cd Generic-Stimulus-Controller
```

To fix any pending migrations, run:
```shell
rails db:migrate
```

config/environments/developement.rb -> put your site url you are using to test
```ruby
config.hosts << "your site URL here"
```

Then you can run your server by running if your in Codio:
```shell
rails s -b 0.0.0.0
```

Or by running this if your running locally:
```shell
bin/rails s
```

## Creating Records

### Teachers

#### Creating a Teacher
* Navigate to the Teachers page by going to the "Teachers" link on the navbar
* Click the <code>New Teacher</code> button
* Enter the name and subject
* Click the <code>Add Student</code> button to add as many students as you want
  * Enter each student's name
* Click the <code>Remove Student</code> button to remove specific students
* Click the <code>Save Teacher</code> button to create the teacher with the students you added

#### Editing a Teacher
* Navigate to the show page for a Teacher and click the yellow <code>Edit this Teacher</code> button on the first table entry
* Remove and add students as you need and click <code>Save Teacher</code> to update the teacher

#### Deleting a Teacher
The <code>Destroy this Teacher</code> button will delete the teacher along with ALL associated students in the show page for the teacher

### Students

#### Creating a Student
* Inside of a Teacher record, click the <code>New Student</code> button under the "Students of [teacher name]" heading

This will automatically populate the student form to be associated with the teacher you started with and you can change the dropdown to specify a different teacher instead if needed.

#### Editing a Student
Click the yellow <code>Edit this Student</code> button in the same table entry as the student name to edit a student

#### Deleting a Student
* Click the <code>Show this Student</code> button
* Click the <code>Destroy this Student</code> button to delete the student

## Adding Into Your Project

Run this importmap command if your using importmaps:
```shell
importmap pin @stimulus-components/rails-nested-form
```

With Yarn package manager use:
```shell
yarn add @stimulus-components/rails-nested-form
```

And:
```shell
bundle install
```

**app/javascript/controllers/application.js**

```javascript
import { Application } from "@hotwired/stimulus"

// This will import the Nested Form controller into your javascript to use in your forms
import RailsNestedForm from '@stimulus-components/rails-nested-form' // Add This Line

const application = Application.start()

// This will add the Nested Form components to the application
application.register('nested-form', RailsNestedForm) // Add This Line

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
```

**app/models/teacher.rb**
```ruby
class Teacher < ApplicationRecord
  has_many :students

  // Allows Nested Forms to be utilized
  accepts_nested_attributes_for :students, reject_if: :all_blank, allow_destroy: true // Add This Line
end
```

**app/models/student.rb**
```ruby
class Student < ApplicationRecord
  belongs_to :teacher
end
```

**app/models/teachers_controller.rb**
```ruby
class TeachersController < ApplicationController
  // Other controller actions above here

  private

  def teacher_params
    params
      .require(:teacher)
       .permit(
         students_params: [:id, :_destroy, :name] // Add this with all related parameters to accept nested form attributes
       )
  end
end
```

**app/views/teachers/edit.html.erb**
```html.erb
<%= form_with model: teacher, data: { controller: 'nested-form' } do |form| %>
  <template data-nested-form-target="template">
    <%= form.fields_for :students, Student.new, child_index: 'NEW_RECORD' do |student_fields| %>
      <%= render "student_form", form: student_fields %>
    <% end %>
  </template>

  <%= form.fields_for :students do |student_fields| %>
    <%= render "student_form", form: student_fields %>
  <% end %>

  <!-- Inserted elements will be injected before that target. -->
  <div data-nested-form-target="target"></div>

  <button type="button" data-action="nested-form#add">Add Student</button>

  <%= form.submit 'Save Teacher' %>
<% end %>
```

**app/views/teachers/student_form.html.erb**
```html.erb
<div class="nested-form-wrapper" data-new-record="<%= form.object.new_record? %>">
  <%= form.label :name %>
  <%= form.text_field :name %>

  <button type="button" data-action="nested-form#remove">Remove Student</button>

  <%= form.hidden_field :_destroy %>
</div>
```
