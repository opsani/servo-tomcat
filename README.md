# Tomcat Servo


## Installation

- Install python3 from EPEL (if not present):
```
rpm -ivh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y python34 python34-typing python34-requests.noarch python34-PyYAML
```

- checkout this repository
```
mkdir -p /opt/optune/
cd /opt/optune/
git clone https://github.com/opsani/servo-tomcat.git
cd servo-tomcat
```

- Pull external Opsani dependencies and install systemd service (may require sudo)
```
./install.sh
```

- Create driver config: `app-desc.yaml`. Example:
```

driver:
  tomcat:
    consul_url: http://example.com/foo
    consul_cert: /path/to/cert.pem
    health_check_url: "http://{}/healthcheck"
    health_check_timeout: 10
    health_check_ok_string: "<STATUS>OK</STATUS>"
    start_file: /tmp/tomcat.start.new
    restart_cmd: "true"
    ssh_opts: "-o user=root"

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

- Create servo config: `servo.cfg`. Example:
```
# Account/app id
OPTUNE_ACCOUNT=acme.com
OPTUNE_APP_ID=my_app
```

- Set your authentication token in `optune-auth-token`. Example:
```
my-secret-token
```

- Start servo
```
systemctl start optune-servo
```


## Upgrade
- Run upgrade script. This pulls latest changes from Git and restarts service (may require sudo)
```
./upgrade.sh
```



## Monitor logs
```
journalctl -f -u optune-servo.service
```



