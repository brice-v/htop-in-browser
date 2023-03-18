import http
import time
import psutil

import handlers

# TODO: Implement dev mode so that we can use ctrl+r to reload and refetch pages
http.static(dir_path='./public')

fun publish_cpus() {
    for (true) {
        val usage = psutil.cpu.percent()
        val u = usage.to_json();
        pubsub.publish('/realtime/cpus', u);
        time.sleep(400);
    }
}
val pubcpusid = spawn(publish_cpus);

# api
http.handle("/api/cpus", handlers.cpus)
http.handle_ws("/realtime/cpus", handlers.realtime_cpus);


http.serve(":8000")