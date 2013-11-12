#include <gtk/gtk.h>
#include <stdlib.h>
#include "points.h"
static void destroy( GtkWidget *widget,
		gpointer   data )
{
	gtk_main_quit ();
}


void show_subjects(GtkWidget* , GtkWidget** );
void calculate_run(GtkWidget *, GtkWidget **);


int main(int argc, const char **argv)
{
	GtkWidget *window, *menubar,*submenu, *application, *about, *license, *department_list, *semester_list, *base, *list, *label_group, *list_group, *go, *align;
	int i;
	Department dep;
	Semester sem;
	GtkWidget *active[2];

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
	gtk_menu_attach( GTK_MENU(gtk_menu_item_get_submenu(GTK_MENU_ITEM(application))),license,0,1,1,2);

	gtk_container_add(GTK_CONTAINER(menubar),application);

	department_list = gtk_combo_box_text_new();

	for(dep = CSE; dep<=EI; dep++) 
		gtk_combo_box_text_append_text(GTK_COMBO_BOX_TEXT(department_list), departments[dep]); //make sure its const char* :)
	gtk_combo_box_set_active(GTK_COMBO_BOX(department_list),0);

	base = gtk_box_new(GTK_ORIENTATION_VERTICAL,10);

	semester_list = gtk_box_new(GTK_ORIENTATION_HORIZONTAL,10);

	list = gtk_combo_box_text_new();

	for (sem = one; sem <=eight; sem++) 
		gtk_combo_box_text_append_text(GTK_COMBO_BOX_TEXT(list), g_strdup_printf("%d",sem+1) );
	gtk_combo_box_set_active(GTK_COMBO_BOX(list),0);

	label_group = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	list_group = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);

	gtk_box_pack_start(GTK_BOX(label_group), gtk_label_new("Department : "), TRUE, TRUE, 0 );
	gtk_box_pack_start(GTK_BOX(label_group), gtk_label_new("Semester : "), TRUE, TRUE, 0 );

	gtk_box_pack_start(GTK_BOX(list_group),department_list, TRUE, TRUE, 0 );
	gtk_box_pack_start(GTK_BOX(list_group),list, TRUE, TRUE, 0 );

	active[0] = department_list;
	active[1] = list;
	go = gtk_button_new_with_label("Go");
	g_signal_connect(go,"clicked", G_CALLBACK(show_subjects),active );

	align = gtk_alignment_new(1,1,0,0);
	gtk_alignment_set_padding(GTK_ALIGNMENT(align),0,10,0,10);
	gtk_container_add(GTK_CONTAINER(align), go);

	gtk_box_pack_start(GTK_BOX(semester_list), gtk_separator_new(GTK_ORIENTATION_VERTICAL), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), label_group, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), gtk_separator_new(GTK_ORIENTATION_VERTICAL), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), list_group, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(semester_list), gtk_separator_new(GTK_ORIENTATION_VERTICAL), FALSE, FALSE, 0);

	gtk_box_pack_start(GTK_BOX(base), menubar, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_image_new_from_file("logo.png"), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_separator_new(GTK_ORIENTATION_HORIZONTAL), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), semester_list, FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), gtk_separator_new(GTK_ORIENTATION_HORIZONTAL), FALSE, FALSE, 0);
	gtk_box_pack_start(GTK_BOX(base), align, FALSE, FALSE, 0);
	gtk_widget_show_all(base);

	gtk_container_add(GTK_CONTAINER(window), base);

	gtk_main();

	return 0;
}

gint Dep,Sem;
GtkWidget *subjects_window;
GtkWidget *grade[10];
void show_subjects(GtkWidget* button, GtkWidget **data) {
	GtkWidget  *content, *subjects, *credits, *grades, *calculate_button, *calculate;
	gchar *grade_list[] = { "S","A","B","C","D","E","U" };
	gint p,i;
	Dep = gtk_combo_box_get_active(GTK_COMBO_BOX(data[0]));
	Sem = gtk_combo_box_get_active(GTK_COMBO_BOX(data[1])) ;

	subjects_window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	gtk_container_set_border_width(GTK_CONTAINER(subjects_window),20);
	gtk_window_set_modal(GTK_WINDOW(subjects_window), TRUE);
	gtk_window_set_position(GTK_WINDOW(subjects_window),GTK_WIN_POS_CENTER);
	// gtk_window_destroy_with_parent(GTK_WINDOW(subjects_window),TRUE);
	gtk_window_set_title(GTK_WINDOW(subjects_window),"Choose Your Grade in each Subject: ");
	gtk_window_set_resizable(GTK_WINDOW(subjects_window),FALSE);

	content = gtk_grid_new();
	// change col spacing

	subjects = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(subjects),gtk_label_new("Subject"), TRUE, TRUE, 10);
	credits = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(credits),gtk_label_new("Credits"), TRUE, TRUE, 10);

	grades = gtk_box_new(GTK_ORIENTATION_VERTICAL,0);
	gtk_box_pack_start(GTK_BOX(grades),gtk_label_new("Grade"), TRUE, TRUE, 15);

	for(p = 0; p<no_of_papers[Dep][Sem]; p++) {
		gtk_box_pack_start(GTK_BOX(subjects), gtk_label_new(list[Dep][Sem][p].paper), TRUE, TRUE, 0);
		gtk_box_pack_start(GTK_BOX(credits), 
				gtk_label_new(
					g_strdup_printf("%d",list[Dep][Sem][p].points)), TRUE, TRUE, 0);

		grade[p] = gtk_combo_box_text_new();

		for(i=0;i<7;i++)
			gtk_combo_box_text_append_text(GTK_COMBO_BOX_TEXT(grade[p]), grade_list[i]); 
		gtk_combo_box_set_active(GTK_COMBO_BOX(grade[p]),0);
		gtk_box_pack_start( GTK_BOX(grades), grade[p], TRUE, TRUE, 0);


	}
	gtk_grid_attach_next_to(GTK_GRID(content),subjects,NULL,GTK_POS_RIGHT,1,1);
	gtk_grid_attach_next_to(GTK_GRID(content),credits,NULL,GTK_POS_RIGHT,1,1);
	gtk_grid_attach_next_to(GTK_GRID(content),grades,NULL,GTK_POS_RIGHT,1,1);

	calculate_button = gtk_button_new_with_label("Calculate GPA");
	g_signal_connect(calculate_button,"clicked",G_CALLBACK(calculate_run),NULL);
	calculate = gtk_alignment_new(1,1,0,0);
	gtk_container_add(GTK_CONTAINER(calculate),calculate_button);

	gtk_grid_attach(GTK_GRID(content), calculate, 0,3,1,2);

	gtk_container_add(GTK_CONTAINER(subjects_window),content);
	gtk_widget_show_all(subjects_window);

}

void del_dialog(GtkWidget* dialog, gpointer data) {
	gtk_widget_destroy(dialog);
}
GtkWidget *dialog;
void calculate_run(GtkWidget *button, GtkWidget *g[]) {

	float sum=0.0,total=0.0;
	int n = no_of_papers[Dep][Sem],i;
	int point_active[10];

	for(i=0; i<n; i++) {
		switch( (int)gtk_combo_box_get_active(GTK_COMBO_BOX(grade[i])) ) {
			case 0: point_active[i] = 10.0; break;
			case 1: point_active[i] = 9; break;
			case 2: point_active[i] = 8; break;
			case 3: point_active[i] = 7; break;
			case 4: point_active[i] = 6; break;
			case 5: point_active[i] = 5; break;
			case 6: point_active[i] = 0; break;
		}


		total += ( (list[Dep][Sem][i].points) * (point_active[i]) );
		sum += list[Dep][Sem][i].points;
	}


	dialog = gtk_message_dialog_new(GTK_WINDOW(subjects_window),GTK_DIALOG_DESTROY_WITH_PARENT,GTK_MESSAGE_INFO, GTK_BUTTONS_OK,
			"Your GPA is %f !", total/sum);

	gtk_window_set_title( GTK_WINDOW(dialog),"Your GPA");
	g_signal_connect(dialog, "response", G_CALLBACK(del_dialog),NULL);
	gtk_dialog_run( GTK_DIALOG(dialog) );
}



