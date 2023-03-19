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
        #println('ws #{ws} received = #{topic_msg}')
        match topic_msg {
            {topic: '/realtime/cpus', msg: _} => {
                try {
                    ws.send(topic_msg.msg);
                } catch (e) {
                    println("ws send failed err=#{e}. (probably closed by client) unsubscribing and returning null...");
                    sub.unsubscribe();
                    return null;
                }
            },
            _ => {
                println("exiting /realtime/cpus");
                sub.unsubscribe();
                return null;
            },
        }
    }
}