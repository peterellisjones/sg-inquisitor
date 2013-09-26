The Security Group Inquisitor
======

The Security Group Inquisitor is a Ruby gem that uses the AWS Ruby SDK to torture bad AWS security groups. 

## Rules

### No Port Ranges
Port ranges are dangerous. You must specify ports explicitly. The Inquisitor will delete any permissions with port ranges.

__Bad__
    ![](http://i.imgur.com/4bJv1WJ.png)
    
__Good__
    ![](http://i.imgur.com/ppfUP6n.png)
    
    
### No IP Ranges
IP Ranges are dangerous. Unless security groups are whitelisted as public, The Inquisitor will delete any permissions allowing access on _0.0.0.0/32_

__Bad__
    ![](http://i.imgur.com/D1RWt3Q.png)
    
__Good__
    ![](http://i.imgur.com/1u721mC.png)
    
### No IPs
If you allow access to an IP on any port, you must add this to the IP whitelist. Otherwise the permission gets deleted. This way when your office IP changes, you can re-run the inquisitor and make sure those old IP addresses get removed from your security groups.

## How to use The Security Group Inquisitor

### Load the gem

### Initialize with your AWS credentials

### Inquisit!

_No security group expects The Security Group Inquisitor!_