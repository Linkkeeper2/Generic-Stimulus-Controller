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
