var kafka = require('kafka-node');
var moment = require('moment');
var elasticsearch = require('elasticsearch');

var BULKSIZE = 1024;
var TYPE = 'events';

// map kafka input topic to ES index and pipeline
var config = {
  'apache': {
    'index': 'apache',
    'pipeline': 'apache',
    'rotate': 'weekly'
  },
  'syslog': {
    'index': 'syslog',
    'rotate': 'weekly'
  },
  'suricata': {
    'index': 'suricata',
    'pipeline': 'suricata',
    'rotate': 'weekly'
  },
  'cee': {
    'index': 'cee',
    'rotate': 'weekly'
  }
}
var topics = []

Object.keys(config).forEach(function(key){
  topics.push({
    topic: key
  })
});

function newTimeValues() {
  return {
    'year': moment().year(),
    'month': moment().month(),
    'week': moment().week()
  }
}
var rotate = newTimeValues();

var Consumer = kafka.Consumer,
  client = new kafka.Client(),
  consumer = new Consumer(
  client,
    topics,
    {
      autoCommit: true
    }
  );

var client = new elasticsearch.Client({
  host: 'localhost:9200'
});

var count = 0;
  bulk = [];

consumer.on('message', function (message) {
  count++;
  var index = config[message.topic]['index'] + '-' + rotate.year;
  // I assume near-realtime stream, thus current week is good enough (no need to parse rfc3339 timestamp)
  if (config[message.topic]['rotate'] == 'weekly' ) {
    index = index + 'w' + rotate.week;
  } else {
    index = index + 'm' + rotate.month;
  } ;
  var meta = {
    "index": {
      '_index': index,
      '_type': TYPE
    }
  };
  if (config[message.topic]['pipeline']) meta['index']['pipeline'] = config[message.topic]['pipeline'];
  bulk.push(meta);
  bulk.push(message.value);
  if (count % BULKSIZE === 0  ) {
    // overhead may be low, but I really don't want to compute index timestamp value on every log message
    rotate = newTimeValues();
    client.bulk({
      body: bulk
    }, function(err, resp) {
      if (err) { console.log(err); };
    });
    bulk = [];
  }
});
