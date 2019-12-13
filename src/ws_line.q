\l m64/kfk.q
h:hopen`::5001; /* connect to rdb */
kfk_cfg:`metadata.broker.list`statistics.interval.ms!`localhost:9092`10000

producer:.kfk.Producer[kfk_cfg]

test_topic:.kfk.Topic[producer;`match;()!()]

match_snapshot:{
 r1: h"match_score()";
 r2: h"match_1x2()";
 msg_score: .j.j r1;
 msg_1x2: .j.j r2;
 show msg_score;
 show msg_1x2;
 }



