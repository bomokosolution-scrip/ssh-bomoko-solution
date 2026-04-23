#!/bin/bash

tmux new-session -d -s a0 'badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 250 --max-connections-for-client 3'
tmux new-session -d -s b0 'dropbear -REF -p 40000 -W 65535'

export PORT=${PORT:-8080}
node proxy3.js
