#!/bin/bash
n=6     # number of switches
for i in {1..2000}
do
    for ((j = 1; j <= n; j++))
    do
        echo "Inspection no. $i at s$j"
        # extract essential data from raw data
        sudo ovs-ofctl dump-flows s$j > data/raw
        grep "nw_src" data/raw > data/flowentries.csv
        packets=$(awk -F "," '{split($4,a,"="); print a[2]","}' data/flowentries.csv)
        bytes=$(awk -F "," '{split($5,b,"="); print b[2]","}' data/flowentries.csv)
        ipsrc=$(awk -F "," '{out=""; for(k=2;k<=NF;k++){out=out" "$k}; print out}' data/flowentries.csv | awk -F " " '{split($11,d,"="); print d[2]","}')
        ipdst=$(awk -F "," '{out=""; for(k=2;k<=NF;k++){out=out" "$k}; print out}' data/flowentries.csv | awk -F " " '{split($12,d,"="); print d[2]","}')
        # check if there are no traffics in the network at the moment.
        if test -z "$packets" || test -z "$bytes" || test -z "$ipsrc" || test -z "$ipdst" 
        then
            state=0
        else
            echo "$packets" > data/packets.csv
            echo "$bytes" > data/bytes.csv
            echo "$ipsrc" > data/ipsrc.csv
            echo "$ipdst" > data/ipdst.csv
            
            python3 computeTuples.py
            python3 inspector.py
            state=$(awk '{print $0;}' .result)
        fi

        if [ $state -eq 1 ];
        then
            echo "Network is under attack occuring at s$j"
            sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.1,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.2,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.3,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.4,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.5,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.6,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.7,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.8,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.9,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.10,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.11,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.12,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.13,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.14,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.15,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.16,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.17,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.18,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.19,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.20,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_src=10.0.0.21,priority=60000,actions=output:2
		sudo ovs-ofctl add-flow s6 ip,nw_dst=10.0.0.1,priority=50000,actions=drop

            default_flow=$(sudo ovs-ofctl dump-flows s$j | tail -n 1)    # Get flow "action:CONTROLLER:<port_num>" sending unknown packet to the controller
            sudo ovs-ofctl del-flows s$j
            sudo ovs-ofctl add-flow s$j "$default_flow"
        fi
    done
    sleep 3
done



# ==============================================================================================================================================
# Ref
# Get all fields (n columns) in awk: https://stackoverflow.com/a/2961711/11806074
# e.g. awk -F "," '{out=""; for(i=2;i<=NF;i++){out=out" "$i" "i}; print out}' data/flowentries.csv 

# ovs-ofctl reference
# add-flow SWITCH FLOW        add flow described by FLOW    e.g. ... add-flow s1 "flow info"
# add-flows SWITCH FILE       add flows from FILE           e.g. ... add-flows s1 flows.txt

# example of multiple commands in awk, these commands below extract ip_src and ip_dst from flow entries
# awk -F "," '{split($10,c,"="); print c[2]","}' data/flowentries.csv > data/ipsrc.csv
# awk -F "," '{split($11,d,"=");  split(d[2],e," "); print e[1]","}' data/flowentries.csv > data/ipdst.csv
