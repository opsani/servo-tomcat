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
    start_file: /path/to/tomcat.start
    restart_cmd: /path/to/myapp.restart
    ssh_opts: "-o user=myUser"
    instances:
      gui:
        - 127.0.0.1

components:
  gui:
     settings:
       InitialHeapSize: {}
       MaxHeapSize: {}
       MaxGCPauseMillis: {}
       MaxGCMinorPauseMillis: {}
       GCTimeRatio: {}
       UseParallelOldGC: {}
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



