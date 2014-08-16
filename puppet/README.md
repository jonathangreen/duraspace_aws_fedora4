# FCRepo4 Cloudformation Puppet Script 

If you would like to use this template all you have to do is download the template file [cloudformation.template](cloudformation.template?raw=true) and follow the instructions [here](../README.md).

## Details

This folder is based on the shell script template. Instead of initializing the system using a cloud-init YAML file it instead bootstrapps the system with the YAML file and then runs puppet in masterless mode. Puppet is then used to setup the rest of the box. 

In the future this could be extended to connect to a puppet master, however for setting up a single node masterless puppet keeps the configuration simple. 

Details of the actual modules can be found inline in comments.
