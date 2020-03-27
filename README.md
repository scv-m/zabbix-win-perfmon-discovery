# Zabbix Windows Performance Counter Discovery

## Table of Contents

- [Limitations](#limits)
- [About](#about)
- [Getting Started](#getting_started)
- [Adding additional counters](#add)



## Limitations <a name = "limits"></a>
- Does not support two performance counters that start with the same two letters  
eg. `Tcp_IPv4` & `Tcp_IPv6`. Will be fixed soon!

## About <a name = "about"></a>

Easily discover performance counters for a chosen class within PerfRawData and add more on the fly. 
Out of the box includes all counters for:
- DHCP Server (_Win32_PerfRawData_DHCP_Server_)
- DNS (_Win32_PerfRawData_DNS_DNS_)


## Getting Started <a name = "getting_started"></a>

1. Copy perf_counter_discovery.ps1 to a folder CustomScripts in your Zabbix Agent directory. eg  
`C:\Program Files\Zabbix Agent\CustomScripts\perf_counter_discovery.ps1`  
2. Add the line below to your zabbix_agentd.conf
`UserParameter=perf_counter.discover[*],powershell -noninteractive -file "C:\Program Files\Zabbix Agent\CustomScripts\perf_counter_discovery.ps1" $1`
3. Import perf_counter_discovery.xml template to Zabbix


## Adding additional counters <a name = "add"></a>
#### Performance Counter names are case sensitive!
1. Import `perf_counter_discovery.xml` to Zabbix
2. Open template `Discover Performance Counters`and clone existing discovery rule such as **Discover DNS Performance Counters**
   1. Change name to accurately reflect your new counter
   2. Replace key value with your new counter eg. from `perf_counter.discover[DNS]` to `perf_counter.discover[Tcp_IPv4]`
3. Create new **Item Prototype** with the below settings:  
   1. Replace **DN** in {#**DN**LA} & {#**DN**NA} with the first two letters of your counter name.  
For example, if your new counter is Tcp_IPv4 use {#Tcp_IPv4}
