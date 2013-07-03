require 'gtk2'
window  = Gtk::Window.new
window.title = "GPA Calculator for Anna University"
window.resizable = false
window.window_position = Gtk::Window::POS_CENTER
base = Gtk::VBox.new(false,10) 

image = Gtk::Image.new(value = "logo.png")

# semester_$list
semester_list = Gtk::HBox.new(false,10)

department = Gtk::Label.new
department.set_markup("<b>Department :</b> ")
$departments = [ 
		"Computer Science and Engineering",
		"Information Technology",
		"Electronics and Communication Engineering",
		"Mechanical Engineering",
		"Electrical and Electronics Engineering" ]

$department_list = Gtk::ComboBox.new(is_text_only = true)
$departments.each do |yessssss|
	$department_list.append_text yessssss
	end
name = Gtk::Label.new
name.set_markup("<b>Semester :</b> ")
## combobox for semester_$list
$list = Gtk::ComboBox.new(is_text_only = true)
(1..8).each do |blah|
$list.append_text blah.to_s
end

$department_list.active = $list.active = 0
label_group =  Gtk::VBox.new(false,0)
list_group =  Gtk::VBox.new(false,0)

[department,name].each do |shit|
label_group.pack_start(shit,true,true,0)
end
[$department_list,$list].each do |crap|
list_group.pack_start(crap, true, true, 0)
end
# Get Button
go = Gtk::Button.new("Go")
go.set_size_request  70, 30
align = Gtk::Alignment.new 1,1,0,0
align.left_padding =  1
align.add go
# pack semester label and combobox
[label_group,Gtk::VSeparator.new,list_group,Gtk::VSeparator.new].each do |blah| 
semester_list.pack_start(blah,false,false,0)
end

# pack logo, semester_$list, subjects and :P
[image,Gtk::HSeparator.new,semester_list,Gtk::HSeparator.new,align].each do |blah|
base.pack_start(blah,false,false,0)
end


window.signal_connect("delete_event") do 
Gtk.main_quit
false
end

$semester = {
1 =>
	{ "Technical English I"	     => 4,
	  "Mathematics I"            => 4,
	  "Engineering Physics I"    => 3,
	  "Engineering Chemistry I"  => 3,
	  "Engineering Graphics"     => 5,
	  "FOC"                      => 3,
	  "CP LAB I"                 => 2,
	  "EP LAB" 	             => 2  },
2 =>
	{  
	  "Technical English II" 			=> 4, 
	  "Mathematics II"                              => 4,
	  "Engineering Physics II"                      => 3,
	  "Engineering Chemistry II"                    => 3,
	  "Electric Circuits and Electron Devices"      => 4,
	  "Basic Civil and Mechanical Engineering"      => 4,
	  "CP LAB II"                                   => 2,
	  "Physics and Chemisty LAB "                   => 2,
	  "EDC LAB"                                     => 2  }
	  }

 
go.signal_connect('clicked') do 
show_subjects
end

def show_subjects
subjects_window = Gtk::Window.new
subjects_window.modal = true
subjects_window.window_position = Gtk::Window::POS_CENTER
subjects_window.destroy_with_parent = true
subjects_window.title = "Choose Your Grade in each Subject:"
subjects_window.resizable = false

content = Gtk::Table.new(2, 3, true)
subjects = Gtk::VBox.new(false,0)
credicts = Gtk::VBox.new(false,0)
grades = Gtk::VBox.new(false,0)
grade = {} # hash of each combobox
sem =  $list.active_text.to_i
 
$semester[sem].keys.each do |blah|
	subjects.pack_start(Gtk::Label.new(blah), true, true, 0)
	credicts.pack_start(Gtk::Label.new(($semester[sem][blah]).to_s), true, true, 0)
	grade[blah] = Gtk::ComboBox.new
	["S","A","B","C","D","E"].each do |yeah|
 	grade[blah].append_text yeah
	end
	grade[blah].active = 0
	grades.pack_start(grade[blah],true,true,0)
	
end
content.attach(subjects,0,1,0,1)
content.attach(credicts,1,2,0,1)
content.attach(grades,2,3,0,1)
calculate = Gtk::Button.new("Calculate GPA")
content.attach(calculate,0,3,1,2)
subjects_window.add(content)
subjects_window.show_all
  
calculate.signal_connect('clicked') do
points = {}
sum = 0.0
total = 0.0
grade.keys.each do |damn|
case grade[damn].active_text
                 when 'A'  then  points[damn]= 9
                 when 'B'  then  points[damn]= 8
                 when 'C'  then  points[damn]= 7
                 when 'D'  then  points[damn]= 6
                 when 'E'  then  points[damn]= 5
                 when 'S'  then  points[damn]= 10
		 end
	end
                           
$semester[sem].keys.each do |cool|
total  += $semester[sem][cool]*points[cool]
sum += $semester[sem][cool]
end

dialog = Gtk::MessageDialog.new( subjects_window,
				Gtk::MessageDialog::DESTROY_WITH_PARENT,
				Gtk::MessageDialog::INFO,
				Gtk::MessageDialog::BUTTONS_OK,
				message="Your GPA is #{total/sum} !")

dialog.signal_connect('response') do
dialog.destroy
end


dialog.run
end
end

window.add(base)

# $list.active = 0 # why ? cuz it just works :P
window.show_all
Gtk.main
