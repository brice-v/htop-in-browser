import time
import psutil

fun cpus() {
    val usage = psutil.cpu.percent()
    println("/cpus called: usage = #{usage}")
    usage.to_json()
}

fun realtime_cpus(ws) {
    println("/realtime/cpus called: ws=#{ws}");
    var sub = pubsub.subscribe('/realtime/cpus')
    for (true) {
        val topic_msg = sub.recv();
        match topic_msg {
            {topic: '/realtime/cpus', msg: _} => {
                ws.send(topic_msg.msg);
            },
            _ => {
                println("exiting /realtime/cpus");
                sub.unsubscribe();
                return NULL;
            },
        }
    }
}