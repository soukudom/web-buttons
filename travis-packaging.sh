#!/bin/sh

sudo apt-get install qemu-user qemu-user-static
echo 'qemu installed'

echo 'global:
  version: "1.0"
  active: default
  debug: false
  fogportalprofile:
    fogpip: ""
    fogpport: ""
    fogpapiprefix: ""
    fogpurlscheme: ""
  dockerconfig:
    server_uri: ""
    api_version: ""
author:
  name: |
    Cisco
  link: www.cisco.com
profiles: {default: {host_ip: 127.0.0.1, host_port: 8443, auth_keys: cm9vdDo=, auth_token: "",
    local_repo: /software/downloads, api_prefix: /iox/api/v2/hosting/, url_scheme: https,
    ssh_port: 22, rsa_key: "", certificate: "", cpu_architecture: "", middleware: {
      mw_ip: "", mw_port: "", mw_baseuri: "", mw_urlscheme: "", mw_access_token: ""}}}' >  /home/travis/.ioxclientcfg.yaml

#FILE1=opc-plugin/Dockerfile
#FILE2=opc-plugin/opcPlugin.py
#FILE3=opc-plugin/package_config.ini
#FILE4=opc-plugin/requirements.txt
#if [ -f "$FILE1" -a -f "$FILE2" -a -f "$FILE3" -a -f "$FILE4" ]; then
#	echo "$FILE1"
#	echo "$FILE2"
#	echo "$FILE3"
#  echo "$FILE4"
#	echo "are present. Commencing packaging"
        docker build --tag iox-web web-app
        rm -rf iox-web-aarch64 && mkdir iox-web-aarch64
        docker save -o rootfs.tar iox-web
        mv rootfs.tar iox-web-aarch64/
#else
#	echo "One or more of the files not present. Cannot create container"
#fi

echo 'descriptor-schema-version: "2.7"

info:
  name: "iox_web_app"
  description: "Web keypad app"
  version: "1.0"
  author-link: "http://www.cisco.com"
  author-name: "Cisco"

app:
  cpuarch: "aarch64"
  type: "docker"
  resources:
    profile: c1.tiny
    network:
      - interface-name: eth0
        ports: {}

  startup:
    rootfs: rootfs.tar
    target: ["python3","/app/app.py"]' > package.yaml

mv package.yaml iox-web-aarch64/
#cp package_config.ini iox-web-aarch64
ioxclient package iox-web-aarch64
