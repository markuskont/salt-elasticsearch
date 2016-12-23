{
  "description" : "process apache logs",
  "processors" : [
    {
      "grok": {
        "field": "message",
        "patterns": ["(?:<%{DATA:syslog_pri}>)?%{DATA:syslog_timestamp} %{DATA:syslog_hostname} %{DATA:syslog_program}(?:\\[%{POSINT:syslog_pid}\\])?:? %{GREEDYDATA:syslog_message}"]
      }
    },
    {
      "remove": {
        "field": "message"
      }
    }
  ]
}
