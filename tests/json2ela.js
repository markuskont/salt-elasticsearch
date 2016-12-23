// npm install elasticsearch
var readline = require('readline');
var fs = require('fs');

INPUT     = '/vagrant/data/apache.log.1'
INDEX     = 'apache-2016.12'
TYPE      = 'logs'
PIPELINE  = 'apache'

var elasticsearch = require('elasticsearch');
var client = new elasticsearch.Client({
  host: 'localhost:9200'
});
function readInput (index,type){
  var count = 0;
  var reqs = 0;
  var resps = 0;
  var bulk = [];
  var cache = {};
  var bulksize = 1024;
  var rl = readline.createInterface({
    input: fs.createReadStream(INPUT),
    output: process.stdout,
    terminal: false
  });
  rl.on('line', function(line){
    count++;
    var meta = {
      "index": {
        '_index': INDEX,
        '_type': TYPE
      }
    };
    var source = {
      'message': line
    };
    bulk.push(meta);
    bulk.push(source);
    if (count % bulksize === 0  ) {
      if (reqs == 15) {
        rl.pause();
        reqs = 0;
      };
      client.bulk({
        body: bulk,
        pipeline: PIPELINE
      }, function(err, resp) {
        resps++;
        if (resps == 14) {
          rl.resume();
          resps = 0;
        }
      });
      console.log(count);
      bulk = [];
      reqs++;
    }
  });
  rl.on('close',function(){
    // send leftovers
    console.log(bulk[0])
    //process.exit(0);
  });
}

readInput(INDEX, TYPE);
