#include <gtk/gtk.h>
#include "points.h"
static void destroy( GtkWidget *widget,
		gpointer   data )
{
	gtk_main_quit ();
}

/*
void show_subjects() {
	GtkWidget *subjects_window, *content, *subjects, *credits, *grades;
	subjects_window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	gtk_container_set_border_width(GTK_WINDOW(subjects_window),20);
	gtk_window_set_modal(GTK_WINDOW(subjects_window), TRUE);
	gtk_window_set_position(GTK_WINDOW(subjects_window),GTK_WIN_POS_CENTER);
	gtk_window_destroy_with_parent(GTK_WINDOW(subjects_window),TRUE);
	gtk_window_set_title(GTK_WINDOW(subjects_window),"Choose Your Grade in each Subject: ");
	gtk_window_set_resizable(GTK_WINDOW(subjects_window),FALSE);

	content = gtk_table_new(2,3,FALSE);
	// change col spacing

	subjects = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(subjects),gtk_label_new("Subject"), TRUE, TRUE, 10);
	credits = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(credits),gtk_label_new("Credits"), TRUE, TRUE, 10);

	grades = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(grades),gtk_label_new("Grade"), TRUE, TRUE, 15);



}
*/

int main(int argc, const char **argv)
{
	GtkWidget *window, *menubar,*submenu, *application, *about, *license, *department_list, *semester_list, *base, *list, *label_group, *list_group, *go, *align;
	int i;
	Department dep;

	gtk_init (&argc, &argv);
	window = gtk_window_new (GTK_WINDOW_TOPLEVEL);

	gtk_window_set_title (GTK_WINDOW (window), "GPA Calculator for Anna University");
	gtk_window_set_resizable(GTK_WINDOW(window),FALSE);
	gtk_window_set_position(GTK_WINDOW(window),GTK_WIN_POS_CENTER);
	g_signal_connect (window, "destroy", G_CALLBACK (gtk_main_quit), NULL);
	gtk_widget_show_all(window);


	menubar = gtk_menu_bar_new();
	application = gtk_menu_item_new_with_label("Application");
	submenu = gtk_menu_new();
	gtk_menu_item_set_submenu(GTK_MENU_ITEM(application),(submenu));
	about = gtk_menu_item_new_with_label("About");
	license = gtk_menu_item_new_with_label("License");

	gtk_menu_attach( GTK_MENU(gtk_menu_item_get_submenu(GTK_MENU_ITEM(application))),about,0,1,0,1);
	gtk_menu_attach( GTK_MENU(gtk_menu_item_get_submenu(GTK_MENU_ITEM(application))),license,0,1,0,1);

	gtk_container_add(GTK_CONTAINER(menubar),application);

	department_list = gtk_combo_box_text_new();

	for(dep = CSE; dep<=EI; dep++) 
		gtk_combo_box_text_append_text(GTK_COMBO_BOX_TEXT(department_list), departments[dep]); //make sure its const char* :)
	gtk_combo_box_set_active(GTK_COMBO_BOX(department_list),0);

	base = gtk_box_new(GTK_ORIENTATION_VERTICAL,10);

	semester_list = gtk_box_new(GTK_ORIENTATION_HORIZONTAL,10);

	list = gtk_combo_box_text_new();

	for (i = 1; i <=8; i++) 
		gtk_combo_box_text_append_text(GTK_COMBO_BOX_TEXT(list), g_strdup_printf("%d",i) );
	gtk_combo_box_set_active(GTK_COMBO_BOX(list),0);

	label_group = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	list_group = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);

	gtk_box_pack_start(GTK_BOX(label_group), gtk_label_new("Department : "), TRUE, TRUE, 0 );
	gtk_box_pack_start(GTK_BOX(label_group), gtk_label_new("Semester : "), TRUE, TRUE, 0 );

	gtk_box_pack_start(GTK_BOX(list_group),department_list, TRUE, TRUE, 0 );
	gtk_box_pack_start(GTK_BOX(list_group),list, TRUE, TRUE, 0 );

	go = gtk_button_new_with_label("Go");
	// g_signal_connect(go,"clicked", G_CALLBACK(show_subjects), NULL);

	align = gtk_alignment_new(1,1,0,0);
	gtk_alignment_set_padding(GTK_ALIGNMENT(align),0,10,0,10);
	gtk_container_add(GTK_CONTAINER(align), go);

	gtk_box_pack_start(GTK_BOX(semester_list), gtk_vseparator_new(), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), label_group, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), gtk_vseparator_new(), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), list_group, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), gtk_vseparator_new(), FALSE, FALSE, 0);
	gtk_widget_show_all(semester_list);


	gtk_box_pack_start(GTK_BOX(base), menubar, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_image_new_from_file("logo.png"), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_hseparator_new(), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), semester_list, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_hseparator_new(), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), align, FALSE, FALSE, 0);
	gtk_widget_show_all(base);

	gtk_container_add(GTK_CONTAINER(window), base);

	gtk_main();







	return 0;
}
