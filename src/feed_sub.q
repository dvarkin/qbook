/////////////
// setup Kafka
//// kafka

queue: ()!();

clean_queue:{queue:: () ! ();}

\l m64/kfk.q
// create consumer process within group 0
client:.kfk.Consumer[`metadata.broker.list`group.id!`localhost:9092`0];

.kfk.consumecb:{[msg]
 data: decode["c"$msg[`data]];
 insert_score[data];
 insert_1x2[data];
// show data;
 match_id: data[`match_id];
 match_state: get_match_state match_id ;
 queue[match_id]:match_state;
 }

// Subscribe

.kfk.Sub[client;`test;enlist .kfk.PARTITION_UA];
