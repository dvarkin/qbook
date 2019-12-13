/////////////
// setup Kafka consumer

h:hopen`::5001; /* connect to rdb */


\l m64/kfk.q

// send snapshot back to Kafka

kfk_cfg:`metadata.broker.list`statistics.interval.ms!`localhost:9092`10000

producer:.kfk.Producer[kfk_cfg]

snapshot_topic:.kfk.Topic[producer;`matchSnapshot;()!()]

.z.ts:{[data]
 s: h"get_all_matches_state()";
 msg: .j.j s;
 .kfk.Pub[snapshot_topic;.kfk.PARTITION_UA; msg;"score"];
 }


\t 1000

//select home_team,away_team,home,draw,away,home_score,away_score from get_all_matches_state() where match_id=1

