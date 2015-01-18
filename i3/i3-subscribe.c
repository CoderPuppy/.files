#include <i3ipc-glib/i3ipc-glib.h>
#include <glib/gprintf.h>
#include <stdio.h>

void on_message(GQuark *change, i3ipcWorkspaceEvent *e) {
	printf("change: %s", e->change);
	if(e->old != NULL && e->current != NULL)
		printf(", old: %s, new: %s\n", i3ipc_con_get_name(e->old), i3ipc_con_get_name(e->current));
	else
		printf("\n");
	fflush(stdout);
}

gint main() {
	GError *err = NULL;

	i3ipcConnection *conn;

	conn = i3ipc_connection_new(NULL, NULL);
	
	GClosure *handler;
	handler = g_cclosure_new(G_CALLBACK(on_message), NULL, NULL);
	i3ipc_connection_on(conn, "workspace", handler, &err);
	
	if(err != NULL) {
		g_printf("%s\n", err->message);
		return err->code;
	}

	i3ipc_connection_main(conn);

	/* g_object_unref(conn); */

	return 0;
}
