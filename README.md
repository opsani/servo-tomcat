# servo-tomcat
Optune adjust driver for Tomcat

This driver updates Java settings in a Tomcat startup file (specified in the driver config) and restarts Tomcat so that these changes are applied. All modifications are done on one or more remote hosts over ssh. The host running the driver should be able to SSH to any hosts that are adjusted. The list of hosts to be adjusted is either obtained from consul via a query specified in the config file, or it is provided as part of the config file.

Note: this driver requires `adjust.py` base class from the Optune servo core. It can be copied or symlinked here as part of packaging

# driver configuration

The following parameters can be configured for the driver. The configuration should be in a file named `config.yaml` in the same directory as the driver.

* `consul_url`: Url to use in order to get list of instances
* `consul_cert`: Certificate to use when querying consul. Optional.
* `health_check_url`: Healthcheck url, used to determine if tomcat service has successfully restarted
* `health_check_timeout`: How long to keep trying to check health before giving up. This can be overwritten by OCO's backend
* `health_check_initial_sleep`: How long to sleep (in seconds) after running the restart command before starting to poll the healthcheck url. If not specified, start checking immediately. This can be overwritten by OCO's backend
* `health_check_ok_string`: String to look for in the output of the healthcheck request
* `start_file`: Tomcat start file that will be modified by Optune in order to change settings
* `restart_cmd`: Command to run in order to restart Tomcat after settings in `start_file` are changed
* `ssh_opts`: SSH options to use when connection to a remote host

Example `config.yaml`:

```
tomcat:
  consul_url: http://example.com/foo
  consul_cert: /path/to/cert.pem
  health_check_url: "http://{}/healthcheck"
  health_check_timeout: 10
  health_check_initial_sleep: 60
  health_check_ok_string: "<STATUS>OK</STATUS>"
  start_file: /tmp/tomcat.start.new
  restart_cmd: /tmp/tomcat.start.new 0<&- >/dev/null 2>&1 &
  ssh_opts: "-o user=root"

  # If not using consul, list instances per component
  # instances:
  #   gui:
  #     - localhost
  #     - example.com

  components:
    gui:
      settings:
        InitialHeapSize: {}
        MaxHeapSize: {}
        MaxGCPauseMillis: {}
        MaxGCMinorPauseMillis: {}
        UseParallelOldGC: {}
        GCTimeRatio: {}
```


