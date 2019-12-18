start Kafka

bin/zookeeper-server-start.sh config/zookeeper.properties

bin/kafka-server-start.sh config/server.properties

Create topic

bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test

topic list

bin/kafka-topics.sh --list --bootstrap-server localhost:9092

listen topic

bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test




\l src/tables.q
\l src/feed_sub.q
\l src/ws_line.q
\l src/gen_data.q


