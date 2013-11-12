#!/usr/bin/env ruby
require 'gtk2'

# Main Window
window  = Gtk::Window.new
window.title = "GPA Calculator for Anna University"
window.resizable = false
window.window_position = Gtk::Window::POS_CENTER

# Menubar
menubar = Gtk::MenuBar.new
application = Gtk::MenuItem.new("Application")
application.submenu = Gtk::Menu.new
about = Gtk::MenuItem.new("About")
license = Gtk::MenuItem.new("License")
[about, license].each do |hehehehe|
application.submenu.append hehehehe
end
menubar.append application

# database starts
common_to_cse_it_ece = {  
			"Technical English II"			   => 4, 
			"Mathematics II"                           => 4,
			"Engineering Physics II"                   => 3,
			"Engineering Chemistry II"                 => 3,
			"Electric Circuits and Electron Devices"   => 4,
			"Basic Civil and Mechanical Engineering"   => 4,
			"Computer Practice LAB II"                 => 2,
			"Physics and Chemisty LAB "                => 2,
			"Circuits and Devices LAB"                 => 2	}
common_to_eee_eie = {  
		  "Technical English II" 			=> 4, 
		  "Mathematics II"                              => 4,
		  "Engineering Physics II"                      => 3,
		  "Engineering Chemistry II"                    => 3,
		  "Circuit Theory"				=> 4,
		  "Basic Civil and Mechanical Engineering"      => 4,
		  "Computer Practice LAB II"                    => 2,
		  "Physics and Chemisty LAB "                   => 2,
		  "Electric Circuits LAB"	                => 2	}

# $semester is a hash whose keys are depts & their values are hashes whose keys are sems 
# & their values are hashes whose keys are subjects and their values are credits.
# ;-) this is what I like with Ruby and Hashes xD
$semester = {

"Computer Science and Engineering" => {
	2 => common_to_cse_it_ece,
	3 => {
		"Transforms and Partial Differential Equations"	=> 4,
		"Data Structures"				=> 3,
		"Digital Principles and Systems Design"		=> 4,
		"Object Oriented Programming"			=> 3,
		"Analog and Digital Communication"		=> 4,
		"Environmental Science and Engineering"		=> 3,
		"Digital Lab"					=> 2,
		"Data Structures Lab"				=> 2,
		"Object Oriented Programming Lab"		=> 2	},
	4 => {
		"Probability and Queueing Theory"		=> 4,
		"Design and Analysis of Algorithms"		=> 4,
		"Microprocessors and Microcontrollers"		=> 3,
		"Computer Organization and Architecture"	=> 3,
		"Operating Systems"				=> 3,
		"Database Management Systems"			=> 3,
		"Operating Systems Lab"				=> 2,
		"Data Base Management Systems Lab"		=> 2,
		"Microprocessors Lab"				=> 2	},
	5 => {
		"Software Engineering"				=> 3,
		"Discrete Mathematics"				=> 4,
		"Computer Networks"				=> 3,
		"Theory of Computation"				=> 4,
		"System Software"				=> 4,
		"Programming Paradigms"				=> 3,
		"Network Lab"					=> 2,
		"System Software Lab"				=> 2,
		"Java Lab"					=> 2	},

	6 => {
		"Artificial Intelligence"			=> 3,
		"Principles of Compiler Design"			=> 4,
		"Object Oriented Analysis and Design"		=> 3,
		"Advanced Computer Architecture"		=> 3,
		"Elective  I"					=> 3,
		"Elective  II"					=> 3,
		"Object Oriented Analysis and Design Lab"	=> 2,
		"Communication Skills Lab"			=> 2,
		"Internet Programming Lab"			=> 2	},
	7 => {
		"Engineering Economics & Financial Accounting"	=> 3,
		"Computer Graphics"				=> 3,
		"Mobile and Pervasive Computing"		=> 3,
		"Digital Signal Processing"			=> 3,
		"Elective III"					=> 3,
		"Elective IV"					=> 3,
		"Computer Graphics Lab"				=> 2,
		"Open Source Lab"				=> 2	},
		},
"Information Technology" => {
	2 => common_to_cse_it_ece,
	3 => {
		"Transforms and Partial Differential Equations"	=> 4,
		"Digital Principles and Systems Design"		=> 4,
		"Object Oriented Programming"			=> 3,
		"Data Structures and Algorithms"		=> 3,
		"Principles of Communication"			=> 4,
		"Environmental Science and Engineering"		=> 3,
		"Digital Lab"					=> 2,
		"Data Structures and Algorithms Lab"		=> 2,
		"Object Oriented Programming Lab"		=> 2 	},
	4 => {
		"Probability and Queueing Theory"		=> 4,
		"Database Management Systems"			=> 3,
		"Microprocessors and Microcontrollers"		=> 3,
		"Computer Organization and Architecture"	=> 3,
		"Operating Systems"				=> 3,
		"Software Engineering and Quality Assurance"	=> 3,
		"Operating Systems Lab"				=> 2,
		"Data Base Management Systems Lab"		=> 2,
		"Microprocessors Lab"				=> 2	},
	5 => {
		"Java Programming"				=> 3,
		"Engineering Economics & Financial Accounting"	=> 3,
		"System Software"				=> 4,
		"Computer Networks"				=> 3,
		"Digital Signal Processing"			=> 3,
		"Information Theory and Coding"			=> 3,
		"System Software Lab"				=> 2,
		"Java Programming Lab"				=> 2,
		"Communication Skills Lab"			=> 2	},
	6 => {
		"Network Programming and Management"		=> 3,
		"Object Oriented Analysis and Design"		=> 3,
		"Cryptography and Network Security"		=> 3,
		"Web Technology"				=> 3,
		"Embedded Systems"				=> 3,
		"Elective I"					=> 3,
		"Web Technology Lab"				=> 2,
		"Object Oriented Analysis and Design Lab"	=> 2,
		"Network Lab"					=> 2	},
	7 => {
		"Service Oriented Architecture"			=> 3,
		"Mobile Communication"				=> 3,
		"Computer Graphics"				=> 3,
		"Software Project Management"			=> 3,
		"Elective II"					=> 3,
		"Elective III"					=> 3,
		"Service Oriented Architecture Lab"		=> 2,
		"Computer Graphics Lab"				=> 2	},
	},
"Electronics and Communication Engineering" => {
	2 => common_to_cse_it_ece,
	3 => {
		"Transforms and Partial Differential Equations"			=> 4,
		"Electrical Engineering"					=> 3,
		"Data Structures and Object Oriented Programming in C++"  	=> 3,
		"Digital Electronics"						=> 4,
		"Signals and systems"						=> 4,
		"Electronic Circuits I"						=> 4,
		"Digital Electronics Lab"					=> 2,
		"Electronic Circuits Lab I"					=> 2,
		"Data structures and Object Oriented Programming Lab"		=> 2	},
	4 => {
		"Probability and Random Processes"		=> 4,
		"Electronic Circuits II"			=> 4,
		"Communication Theory"				=> 4,
		"Electromagnetic Fields"			=> 4,
		"Linear Integrated Circuits"			=> 3,
		"Control Systems"				=> 3,
		"Electronics circuits II and simulation Lab"	=> 2,
		"Linear Integrated Circuit Lab"			=> 2,
		"Electrical Engineering and Control System Lab"	=> 2	},
	5 => {
		"Digital Communication"				=> 3,
		"Digital Signal Processing"			=> 4,
		"Computer Architecture and Organization"	=> 3,
		"Transmission Lines and Wave guides"		=> 4,
		"Environmental Science and Engineering"		=> 3,
		"Microprocessors and Microcontrollers"		=> 4,
		"Digital Signal Processing Lab"			=> 2,
		"Communication System Lab"			=> 2,
		"Microprocessors and Microcontrollers Lab"	=> 2	},
	6 => {
		"Principles of Management"		=> 3,
		"Measurements and Instrumentation"	=> 3,
		"Computer Networks"			=> 3,
		"Antenna and Wave Propagation"		=> 4,
		"VLSI Design"				=> 3,
		"Elective I"				=> 3,
		"Computer Networks Lab"			=> 2,
		"VLSI Design Lab"			=> 2,
		"Communication Skills Lab"		=> 2	},
	7 => {
		"Wireless Communication"		=> 3,
		"Optical Communication and Networks"	=> 3,
		"RF and Microwave Engineering"		=> 3,
		"Elective II"				=> 3,
		"Elective III"				=> 3,
		"Elective IV"				=> 3,
		"Electronics System Design Lab"		=> 2,
		"Optical & Microwave Lab"		=> 2	},
	},
"Mechanical Engineering" => {
	2 => {
		"Technical English II" 				=> 4, 
		"Mathematics II"              	                => 4,
		"Engineering Physics II"      	                => 3,
		"Engineering Chemistry II"    	                => 3,
		"Engineering Mechanics"				=> 4,
		"Basic Electrical and Electronics Engineering"	=> 4,
		"Computer Practice  LAB II"	            	=> 2, 
		"Physics and Chemisty LAB "               	=> 2,
		"Computer Aided Drafting and Modeling LAB"	=> 2	},
	3 => {
		"Transforms and Partial Differential Equations"	=> 4,
		"Manufacturing Technology  I"			=> 3,
		"Engineering Thermodynamics"			=> 4,
		"Kinematics of Machinery"			=> 4,
		"Fluid Mechanics and Machinery"			=> 4,
		"Electrical Drives and Control"			=> 3,
		"Manufacturing Technology Lab  I"		=> 2,
		"Fluid Mechanics and Machinery Lab"		=> 2,
		"Electrical Engineering Lab"			=> 2	},
	4 => {
		"Statistics and Numerical Methods"=>4,
		"Heat and Mass Transfer"=>4,
		"Manufacturing Technology"=>3,
		"Engineering Materials and Metallurgy"=>3,
		"Strength of Materials"=>4,
		"Electronics and Microprocessors"=>3,
		"Manufacturing Technology Lab"=>2,
		"Strength of Materials Lab"=>2,
		"Computer Aided Machine Drawing Laboratory"=>2},
	5 => {
		"Environmental Science and Engineering"=>3,
		"Database Management Systems"=>4,
		"Design of Machine Elements"=>4,
		"Management of Manufacturing System"=>4,
		"Measurements and Controls"=>3,
		"Applied Hydraulics and Pneumatics"=>3,
		"Dynamics Lab"=>2,
		"Metrology and Measurements Lab"=>2,
		"Computer Aided Machine Drawing Practice"=>2,
		"Database Management Systems Lab"=>2},
	6 => {
		"Principles of Management"=>3,
		"Gas Dynamics and Jet Propulsion"=>4,
		"Design of Transmission Systems"=>4,
		"Automobile Engineering"=>3,
		"Finite Element Analysis"=>4,
		"Elective I"=>3,
		"Thermal Engineering Lab II"=>2,
		"Design & Fabrication Project"=>2,
		"Communication Skills Lab"=>2},
	7 => {
		"Total Quality Management"=>3,
		"Mechatronics"=>3,
		"Computer Integrated Manufacturing"=>3,
		"Power Plant Engineering"=>3,
		"Elective II"=>3,
		"Elective III"=>3,
		"Computer Aided Simulation & Analysis Lab"=>2,
		"Mechatronics Lab"=>2},
	8 => {
		"Engineering Economics and Cost Analysis"=>3,
		"Elective IV"=>3,
		"Elective V"=>3,
		"Comprehension"=>1,
		"Project Work"=>6},
		 
},
"Electrical and Electronics Engineering" => {
	2 => common_to_eee_eie,
	3 => {
		"Transforms and Partial Differential Equations"	=> 4,
		"Measurements & Instrumentation"		=> 3,
		"Electromagnetic Theory"			=> 4,
		"Environmental Science and Engineering"		=> 3,
		"Electronic Devices & Circuits"			=> 3,
		"Data Structures and Algorithms"		=> 4,
		"Electron Devices and Circuits Lab"		=> 2,
		"Data Structures and Algorithms Lab"		=> 2,
		"Measurements & Instrumentation Lab"		=> 2	},
	4 => {
		"Numerical Methods"=>4,
		"Electrical Machines  I"=>4,
		"Power Plant Engineering"=>4,
		"Control Systems"=>4,
		"Linear Integrated Circuits and Applications"=>3,
		"Digital Logic Circuits"=>4,
		"Control Systems Lab"=>2,
		"Linear and Digital Integrated Circuits Lab"=>2,
		"Electrical Machines Lab  I"=>2},
	5 => {
		"Communication Engineering"=>3,
		"Digital Signal Processing"=>4,
		"Object Oriented Programming"=>3,
		"Power Electronics"=>3,
		"Electrical Machines II"=>4,
		"Transmission & Distribution"=>4,
		"Object Oriented Programming Lab"=>2,
		"Communication Skills Lab"=>2,
		"Power Electronics Lab"=>2,
		"Electrical Machines Lab II"=>2},
	6 => {
		"Power System Analysis"=>4,
		"Solid State Drives"=>3,
		"High Voltage Engineering"=>3,
		"Microprocessors and Micro controller"=>3,
		"Design of Electrical Machines"=>4,
		"Computer Networks"=>3,
		"Elective I"=>3,
		"Microprocessor and Micro controller Lab"=>2,
		"Presentation Skills and Technical Seminar"=>1},
	7 => {
		"Power System Operation and Control"=>3,
		"Protection & Switchgear"=>3,
		"Special Electrical Machines"=>3,
		"Principles of Management"=>3,
		"Operating Systems"=>3,
		"Elective II"=>3,
		"Power System Simulation Lab"=>2,
		"Comprehension"=>1},
},
"Electronics and Instrumentation Engineering" => {
	2 => common_to_eee_eie,
	3 => {
		"Transforms and Partial Differential Equations"	=> 4,
		"Environmental Science and Engineering"		=> 3,
		"Electrical Machines"				=> 4,
		"Electronic Devices and Circuits"		=> 3,
		"Data Structures and Algorithms"		=> 4,
		"Electrical Measurements"			=> 4,
		"Electron Devices and Circuits Lab"		=> 2,
		"Data Structures and Algorithms Lab"		=> 2,
		"Electrical Machines Lab"			=> 2	},
		
	4 => {
		"Control Systems"=>4,
		"Industrial Instrumentation I"=>3,
		"Transducer Engineering"=>3,
		"Digital logic Circuits"=>4,
		"Linear Integrated Circuits and Applications"=>3,
		"Applied Thermodynamics"=>4,
		"Transducers and Measurements Lab"=>2,
		"Thermodynamics Lab"=>2,
		"Linear and Digital Integrated circuits Lab"=>2},
	5 => {
		"Microprocessor and  Microcontroller"=>3,
		"Communication Engineering"=>3,
		"Object Oriented Programming"=>3,
		"Industrial Electronics"=>3,
		"Analytical Instruments"=>3,
		"Industrial Instrumentation II"=>3,
		"Microprocessor and Microcontroller Lab"=>2,
		"Object Oriented Programming Lab"=>2,
		"Communication Skills Lab"=>2,
		"Industrial Instrumentation Lab"=>2},
	6 => {
		"Modern Electronic Instrumentation"=>3,
		"Process Control"=>4,
		"Digital System Design"=>3,
		"Digital Signal Processing"=>4,
		"Embedded System"=>3,
		"Biomedical Instrumentation"=>3,
		"Communication and DSP Lab"=>2,
		"Process Control System Lab"=>2,
		"Virtual Instrumentation Lab"=>2},
	7 => {
		"Industrial Data Networks"=>3,
		"Logic and Distributed Control System"=>3,
		"VLSI Design"=>3,
		"Fibre Optics and Laser Instruments"=>3,
		"Elective I"=>3,
		"Elective II"=>3,
		"VLSI Lab"=>2,
		"Instrumentation System Design Lab"=>2,
		"Comprehension"=>2},


	8 => {
		"Principles of Management"=>3,
		"Elective III"=>3,
		"Elective IV"=>3,
		"Project Work"=>6}
}
}

# And here comes the irrelevant subjects to irrelevant fields ...
b1tch_please = { 
		  "Technical English I"     			 => 4,
		  "Mathematics I"           			 => 4,
		  "Engineering Physics I"   			 => 3,
		  "Engineering Chemistry I" 			 => 3,
		  "Engineering Graphics"    			 => 5,
		  "Fundamentals of Computing and Programming "   => 3,
		  "Computer Practice  LAB I"             	 => 2,
		  "Engineering Practice  LAB" 	         	 => 2  }
# and this one where you get credits for others work ...
w_t_f =  {
		"Elective IV"	=> 3,
		"Elective V"	=> 3,
		"Project Work"	=> 6	}
# list of depts
$department_list = Gtk::ComboBox.new(is_text_only = true)

# I missed few data intentionally.. lemme fix that along with filling combobox!
$semester.keys.each do |hell_yeah|
	$semester[hell_yeah][1] = b1tch_please # why on the earth they 've these subjects ????
	$semester[hell_yeah][8] = w_t_f unless ["Mechanical Engineering","Electronics and Instrumentation Engineering"].include? hell_yeah
	$department_list.append_text hell_yeah
	end

# Window holds a VBox 'base'
base = Gtk::VBox.new(false,10) 

# 'base' VBox holds 2 HBox - options & 'go' button 
semester_list = Gtk::HBox.new(false,10) # this will hold options

# lemme fill the semester dropdown list box - dono why they call it combo o_0
$list = Gtk::ComboBox.new(is_text_only = true)
(1..8).each do |blah|
$list.append_text blah.to_s
end

# this one for some who are stupids to click go directly without choosing options
$department_list.active = $list.active = 0

# two VBox - to hold labels and list boxes
label_group =  Gtk::VBox.new(false,0)
list_group =  Gtk::VBox.new(false,0)

# create labels and pack it into label_group
[	Gtk::Label.new.set_markup("<b>Department :</b>"),
	Gtk::Label.new.set_markup("<b>Semester :</b>")
].each do |heat_blast|
label_group.pack_start(heat_blast,true,true,0)
end

# lemme pack the list boxes to list_group
[$department_list,$list].each do |diamond_head| # yeah I like Diamond_head more than Heat_Blast - watch Ben 10 ?
list_group.pack_start(diamond_head, true, true, 0)
end

# Get Button
go = Gtk::Button.new("Go")
align = Gtk::Alignment.new(1,1,0,0) # else go 'll expand in VBOx - won't be nice
align.set_padding(0,10,0,10)
align.add go

# pack label_group and list_group with separators to make it look nice
[Gtk::VSeparator.new,label_group,Gtk::VSeparator.new,list_group,Gtk::VSeparator.new].each do |blah| 
semester_list.pack_start(blah,false,false,0)
end

# pack menu, logo, semester_$list, go button :P
[menubar,Gtk::Image.new(value = "logo.png"),Gtk::HSeparator.new,semester_list,Gtk::HSeparator.new,align].each do |blah|
base.pack_start(blah,false,false,0)
end


window.signal_connect("delete_event") do 
Gtk.main_quit
false
end


go.signal_connect('clicked') do 
show_subjects
end

def show_subjects
subjects_window = Gtk::Window.new
subjects_window.border_width = 20
subjects_window.modal = true
subjects_window.window_position = Gtk::Window::POS_CENTER
subjects_window.destroy_with_parent = true
subjects_window.title = "Choose Your Grade in each Subject:"
subjects_window.resizable = false

content = Gtk::Table.new(2, 3, false)
(0..2).each do |boooooom|
content.set_column_spacing boooooom,25
end
content.set_row_spacing 0,25
subjects = Gtk::VBox.new(false,0)
subjects.pack_start(Gtk::Label.new.set_markup("<b>Subject</b>"),true,true,10)
credits = Gtk::VBox.new(false,0)
credits.pack_start(Gtk::Label.new.set_markup("<b>Credits</b>"),true,true,10)
grades = Gtk::VBox.new(false,0)
grades.pack_start(Gtk::Label.new.set_markup("<b>Grade</b>"),true,true,15)
grade = {} # hash of each combobox
dep = $department_list.active_text
sem =  $list.active_text.to_i
 
$semester[dep][sem].keys.each do |blah|
	subjects.pack_start(Gtk::Label.new(blah), true, true, 0)
	credits.pack_start(Gtk::Label.new(($semester[dep][sem][blah]).to_s), true, true, 0)
	grade[blah] = Gtk::ComboBox.new
	["S","A","B","C","D","E","U"].each do |yeah|
 	grade[blah].append_text yeah
	end
	grade[blah].active = 0
	grades.pack_start(grade[blah],true,true,0)
	
end
content.attach(subjects,0,1,0,1)
content.attach(credits,1,2,0,1)
content.attach(grades,2,3,0,1)
calculate_button = Gtk::Button.new("Calculate GPA")
calculate = Gtk::Alignment.new 1, 1, 0, 0
calculate.add calculate_button 
content.attach(calculate,0,3,1,2)
subjects_window.add(content)
subjects_window.show_all
  
calculate_button.signal_connect('clicked') do
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
                 when 'U'  then  points[damn]= 0
		 end
	end
                           
$semester[dep][sem].keys.each do |cool|
total  += $semester[dep][sem][cool]*points[cool]
sum += $semester[dep][sem][cool]
end

dialog = Gtk::MessageDialog.new( subjects_window,
				Gtk::MessageDialog::DESTROY_WITH_PARENT,
				Gtk::MessageDialog::INFO,
				Gtk::MessageDialog::BUTTONS_OK,
				message="Your GPA is #{(total/sum).round(3)} !") # yeah, I remember my GPA was 7.92 last semester o_O

dialog.signal_connect('response') do
dialog.destroy
end
dialog.title = "Your GPA"
dialog.run
end
end

window.add(base)

window.show_all

about.signal_connect('activate') do 
tell="""
GPA Calculator for Anna University U.G Courses

Version 0.1

By : ShanthaKumar

Please report bugs to mail@shanth.tk

Tweet your feedback @5hanth
""" 

about_dialog = Gtk::MessageDialog.new(window,
				      Gtk::MessageDialog::DESTROY_WITH_PARENT,
				      Gtk::MessageDialog::INFO,
				      Gtk::MessageDialog::BUTTONS_OK,
				      message = tell
				       )
about_dialog.title = "About"
about_dialog.signal_connect('response') do
about_dialog.destroy
end
about_dialog.run
end
license.signal_connect('activate') do 
tell="""
	This program is a free software <www.fsf.org> ,
you can redistribute it and/or modify it as per your wish,
provided that you respect the freedom of others.

	This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

- ShanthaKumar
"""
license_dialog = Gtk::MessageDialog.new(window,
				      Gtk::MessageDialog::DESTROY_WITH_PARENT,
				      Gtk::MessageDialog::INFO,
				      Gtk::MessageDialog::BUTTONS_OK,
				      message = tell
				       )
license_dialog.title = "License Notice"
license_dialog.signal_connect('response') do
license_dialog.destroy
end
license_dialog.run
end

Gtk.main
