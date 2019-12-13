\l m64/kfk.q
numberOfMatches: 200
numberOfGoals: 10
kfk_cfg:`metadata.broker.list`statistics.interval.ms!`localhost:9092`10000

producer:.kfk.Producer[kfk_cfg]

test_topic:.kfk.Topic[producer;`test;()!()]

.z.ts:{
 d: `match_id`home`away!(rand numberOfMatches; rand numberOfGoals; rand numberOfGoals);
 msg: .j.j d;
// show msg;
 .kfk.Pub[test_topic;.kfk.PARTITION_UA; msg;"score"];
// show "sent";
 }




\t 1000
