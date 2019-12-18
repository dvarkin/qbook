#QBOOK 
Sportsbook line manager 

## Q Enviroment

```sh
export QHOME=~/Projects/qbook
export PATH=$PATH:$QHOME/m64
export DEVELOPER_HOME=~/developer
export DEVELOPER_DATA=$DEVELOPER_HOME/data
export DEVELOPER_PORT=8000
alias q='$QHOME/m64/q'
```

## Kafka

### Start server

```sh
bin/zookeeper-server-start.sh config/zookeeper.properties
bin/kafka-server-start.sh config/server.properties
```

### Create topic
```sh
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
```
### Topic list
```sh
bin/kafka-topics.sh --list --bootstrap-server localhost:9092
```

### Listen topic
```sh
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test
```

## Start Q server with test data

```sh
$ q
\l src/tables.q
\l src/feed_sub.q
```

### Run websocket server 

```sh
$ q
\l src/ws_line.q
```

### Run random data generator

```sh
$ q
\l src/gen_data.q
```

open index.html in browser
