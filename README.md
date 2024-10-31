# Demonstration & Detection of Flood Attack using ML
# DDoS-SDN
Tools Used:
● Miniedit: MiniEdit is an experimental tool created to 
demonstrate how Mininet can be extended.

● Mininet: Mininet is a software emulator for 
prototyping a large network on a single machine. 
Mininet can be used to quickly create a realistic 
virtual network running actual kernel, switch and 
software application code on a personal computer.

● Ryu Controller: Ryu Controller is an open, 
software-defined networking (SDN) Controller 
designed to increase the agility of the network by 
making it easy to manage and adapt how traffic is 
handled.

● Python: Python is a general-purpose, high-level, 
interpreted programming language. Its design 
philosophy prioritises code readability and makes 
extensive use of indentation. Its language elements 
and object-oriented approach are aimed at assisting 
programmers in writing clear, logical code for both 
small and big projects.

Methodology:
We make our network using Miniedit and Mininet. Then 
we run the topo.py in mininet in order to load the topology. 
Next we run the custom-ctrl.py python file. This file is run 
on the ryu controller that keeps monitoring the network for 
flood attacks. We run collect.sh file to detect and prevent 
the attack from happening.
We initiate the attack using the Hping3 network security 
tool. The SVM model compares the network traffic with a 
certain threshold which in this case is 1000packets/3sec. 
If the network traffic exceeds this limit then we notify the 
system admin.

Module Description:

Network Creation:
We create a network consisting of 6 switches and 9 PCs. 
These are connected to a Ryu controller that monitors the 
entire network.

Threat Execution:
We initiate an attack on a random pc from the h2 
workstation. The attack is executed by using the Hping3 
tool. We start the attack by using a random-source ip and 
flooding the entire network with false packets. 
This increases the network traffic and overwhelms all the 
switches from the source workstation to the victim 
workstation. 

The following commands were used to initiate various 
forms of flood attacks:
● h2 hping3 --rand-source --flood 10.0.0.1
● h2 hping3 --rand-source --flood -S 10.0.0.1
● h2 hping3 --rand-source --flood -A 10.0.0.1
● h2 hping3 --rand-source --flood -F 10.0.0.1

Prevention Measures:
The attack can be detected by using Wireshark. Wireshark 
gives us details about the current traffic on the network 
and also details such as source ip, destination ip, etc.
In order to mitigate the attack we can use SNORT. 
SNORT can be used to monitor the traffic that goes in and 
out of a network. It will monitor traffic in real time and 
issue alerts to users when it discovers potentially 
malicious packets or threats on Internet Protocol (IP) 
networks. We can assign specific rules through SNORT 
that are used to compare network traffic against certain 
conditions. In case the traffic violates these conditions we 
can also use it to block such traffic.

Running Manual
1. Create a virtual environment via Python: python3 -m venv venv.
2. After that, install all requirements as described in Prerequisite.
3. Next run each one below in a different shell respectively.
4. Start the Ryu controller by running: ryu-manager customCtrl.py
5. Start the SDN topology by running: python3 topo.py
6. Start the collecting and inspecting program by running: source collect.sh


Before Attack:
Before the attack takes place, we can easily ping all the 
switches and PCs that are part of the network. All 
connections are in their normal state and wireshark shows 
an almost flat line for all network traffic.

After Attack:
After the attack has taken place, Wireshark shows 
unusually high traffic on the path that exists between the 
attacker and victim pc. 
Pinging any switch on the same path returns no replies as 
the switches are overloaded with traffic. All other PCs that 
are not on the path under attack are in normal state and 
send replies to pinging attempts.

Recovery After Attack:
As this is a form of flood attack, there are no major file 
losses that are recorded. Once the attack is mitigated using 
SNORT, ACL or firewall configs, the network traffic 
becomes usual and all PCs start responding to any 
communication attempts.

Conclusion:
Flood attacks can be a very effective form of DDoS attack 
wherein the attacker stops any network device from 
providing service to legitimate users by overloading the 
device. This can cause problems in networks that deal with 
real-time data and need information quickly. 
By implementing an SVM based model through the use of 
ryu controller, a network admin can monitor network 
traffic in real time and compare it to predefined threshold 
in order to determine when the network is under some 
potential threat.
Moreover, such attacks can be easily mitigated by using 
software such as SNORT or network security tools such 
as ACL and firewalls that can filter incoming network 
traffic based on rules that have been setup by the 
organisation.

Screenshot:
Network topology
![image](https://user-images.githubusercontent.com/67210839/173204056-8bb9ee98-0788-4dd1-8023-e09eeeb74d13.png)

![image](https://user-images.githubusercontent.com/67210839/173204089-a02298b7-0ee2-471b-9ade-2653196be2c7.png)

![image](https://user-images.githubusercontent.com/67210839/173204100-b13a7534-0dc8-461c-9b5e-c19e64d35cc1.png)
