# FCRepo4 Cloud-Init Scripts

If you would like to use this template all you have to do is download the template file [cloudformation.template](cloudformation.template?raw=true) and follow the instructions [here](../README.md).

## Information 

This script uses a simple Cloud-Init Cloud Config Data YAML file inside the JSON Cloudformation template to initialize the stack. The format of the file is a little hard to read because the YAML inside the JSON has to be escaped, however once you understand that it is fairly easy to read.

Cloud-Init docs here: https://help.ubuntu.com/community/CloudInit

CloudFormation docs here: http://aws.amazon.com/cloudformation/aws-cloudformation-templates/

### Parameters

The CloudFormation template takes 3 parameters:
* InstanceType
 * Allows the user to choose what type of instance to start.
 * Allowed values: t1.micro, m1.small
* SSHLocation
 * The IP address range that can be used to SSH to the EC2 instances. Allows the user to lock down SSH access to the stack. Must be a valid IP CIDR range of the form x.x.x.x/x.
 * Default: 0.0.0.0/0
* KeyName
 * (Optional) Name of an existing EC2 KeyPair to enable SSH access to the instance. If this is not provided you will not be able to SSH on to the EC2 instance.
 
## Script Details

This template first installs all updates, and reboots the server if neccessary. It then installs these packages using apt.

* git
* tomcat7
* ec2-api-tools
* python-setuptools
* fail2ban
* unattended-upgrades

Fail2ban and unattended-upgrades are installed to help secure the server. Fail2ban is a daemon that monitors login attempts to a server and blocks suspicious activity as it occurs. It’s well configured out of the box, so we leave its configuration as is. 

unattended-upgrades is installed to make sure we automatically install security updates. We copy 10periodic out of the files folder to ensure it is configured correctly. 

We then setup the configuration files for authbind so that tomcat can be run on port 80 by an unprivileged user.

We copy some configration files for tomcat from the files folder. These files:
* Setup tomcat to run on port 80
* Enable log deletion for tomcat
* Enable log compression for tomcat

We download the fedora war. Create the fedora home directory with the correct user permissions. Then start tomcat and we have a server. 

We then use the AWS utils to signal that the server is successfully created.
