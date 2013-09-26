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
IP Ranges are dangerous. Unless security groups are whitelisted as public, The Inquisitor will delete any permissions allowing access on _0.0.0.0/0_

__Bad__
    ![](http://i.imgur.com/D1RWt3Q.png)
    
__Good__ (IP must be whitelisted)
    ![](http://i.imgur.com/1u721mC.png)
    
### No IPs
If you allow access to an IP on any port, you must add this to the IP whitelist. Otherwise the permission gets deleted. This way when your office IP changes, you can re-run the inquisitor and make sure those old IP addresses get removed from your security groups.

## How to use The Security Group Inquisitor

### Load the Gem

    # Gemfile
    gem 'sg-inquisitor', :git => 'git://github.com/ukoki/sg-inquisitor.git'

### Initialize with your AWS credentials

    sec_group_inquisitor = SGInquisitor.new access_key: "AKIAABCDEFGHIJKLMNOP", secret_access_key: "abcdefghijklmnopqrstuvwxyz"

### Inquisit!
  
Optionally define "public" security groups that can be accessed by 0.0.0.0/0 (technically, any [CIDR](http://en.wikipedia.org/wiki/CIDR) that isn't 32). You can also define whitelisted IPs (eg the office IP) that can access security groups.

    require 'sg-inquisitor'

    public_security_groups = ["website", "landingpage"]
    whitelisted_ips = ["1.2.3.4"] # the office

    sec_group_inquisitor.inquisit public_security_groups: public_security_groups, whitelisted_ips: whitelisted_ips

The Inquisitor will make sure that unless a security group is whitelisted as "public", no IP range can accesses it, and only whitelisted specific IPs can access it.

_No security group expects The Security Group Inquisitor!_
