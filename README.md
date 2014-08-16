#Duraspace FCRepo4 AWS Scripts

## About
These scripts provide the ability to start a EC2 instance running Fedora 4 on AWS using Cloudformation. There are several scripts: 

* Shell
  * This script uses Cloudformation and cloud-init to bring up the instance. It uses a cloud config data YAML file to install packages and bring up the instance. 

Detailed decriptions of each script can be found in the README file in the scripts folder. Each one brings up an instance in a secure fashion, ensuring that appropriate security groups are given to the instance. 

The Cloudformation templates also uses waitstates to make sure that the user isn't notified of stack creation until Fedora is up and running.

## Using The Scripts

### Web UI

1. Log into AWS Web Console and Click *Cloudformation*.
![](images/awsconsole.png?raw=true)
2. Click on the *Create Stack* button.
![](images/cloudformation.png?raw=true)
3. Fill in the name you would like to give the stack and select the template you would like to use. To use the templates provided in this repository you will have to download the .tempate file to your computer so you can select it in the file browser as shown below. Then click *Next*.
![](images/selecttemplate.png?raw=true)
3. Fill in the appropriate parameters for your instance. The parameters will vary based on the template you are using. The screenshow shown below is from the shell template. Click *Next*.
![](images/parameters.png?raw=true)
4. Specify any tags you would like to give the new instance. Click *Next*.
![](images/tags.png?raw=true)
5. Review the parameters and click *Create*.
![](images/review.png?raw=true)
6. The stack is not being created. 
![](images/creating.png?raw=true)
7. As the components of the stack are created you can see the status in the events tab. When the status gets to AWS::CloudFormation::WaitCondition this indicates that all the hardware in AWS has been provisioned, but we you are waiting for the software to install. This can take some time as all updates are applied and the instance is rebooted as necessary for kernel updated. Then software is installed and fedora is configured.
![](images/events.png?raw=true)
8. Finally you will see the state *CREATE_COMPLETE*. If you click on the outputs tab you will be able to see a link to your new Fedora4 instance. 
![](images/done.png?raw=true)

### AWS CLI

1. Ensure you have the latest AWS CLI client installed. http://aws.amazon.com/cli/
2. If you have not already, configure your AWS CLI client by running `aws configure`
3. Clone this repository or download the template you would like use.
4. Start a new stack by running:
 ```
 $ aws cloudformation create-stack --stack-name awesomestack --template-body file://shell//cloudformation.template 
 ```
 the aws command will return with the identifier of the stack
 ```
 {
     "StackId": "arn:aws:cloudformation:us-east-1:704427155554:stack/awesomestack/88c35cb0-2555-11e4-a55b-50fa1dbb2c64"
 }
 ```
 you can also pass parameters to the stack such as the key pair to use
 ```
 $ aws cloudformation create-stack --stack-name anotherawesomestack --parameters ParameterKey=KeyName,ParameterValue=JonsPubKey --template-body file://shell//cloudformation.template
 ```
5. Check the status of the stack by running:
 ```
 $ aws cloudformation describe-stacks --stack-name anotherawesomestack
 ```
 ```
 {
     "Stacks": [
         {
             "StackId": "arn:aws:cloudformation:us-east-1:704427155554:stack/anotherawesomestack/00855230-2556-11e4-ba9d-50e24162947c", 
             "Description": "This is a template to create a t1.micro or m1.small instance running Fedora 4 under ubuntu.", 
             "Parameters": [
                 {
                     "ParameterValue": "0.0.0.0/0", 
                     "ParameterKey": "SSHLocation"
                 }, 
                 {
                     "ParameterValue": "JonsPubKey", 
                     "ParameterKey": "KeyName"
                 }, 
                 {
                     "ParameterValue": "t1.micro", 
                     "ParameterKey": "InstanceType"
                 }
             ], 
             "Tags": [], 
             "Outputs": [
                 {
                     "Description": "URL for newly created Fedora server", 
                     "OutputKey": "WebsiteURL", 
                     "OutputValue": "http://ec2-54-242-158-74.compute-1.amazonaws.com/fcrepo-webapp-4.0.0-beta-01/"
                 }, 
                 {
                     "Description": "SSH command to connect to new stack.", 
                     "OutputKey": "SSHCommand", 
                     "OutputValue": "ssh ubuntu@ec2-54-242-158-74.compute-1.amazonaws.com"
                 }
             ], 
             "StackStatusReason": null, 
             "CreationTime": "2014-08-16T15:00:03.551Z", 
             "StackName": "anotherawesomestack", 
             "NotificationARNs": [], 
             "StackStatus": "CREATE_COMPLETE", 
             "DisableRollback": false
         }
     ]
 }
 ```
