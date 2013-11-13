The instructions below document the steps to using the Rumm Usergrid provisioning commands now part of the the Rumm command line tool.

The CL tool works in conjunction with the iOS sample app to demonstrate how easily a Usergrid server can be setup and how a simple iOS can send to and receive data from it.


## Using the Rumm Usergrid plug-in

The Rumm Usergrid plugin is designed to quickly and easily spin up a backend server for a mobile app.

The `install usergrind on server :id` command sets up a node with everything you need to run Apigee's Usergrid service.

Then organization, user, application and objects can be setup through the command-line tool. Apigee also provides SDKs for many popular platforms, including Android and iOS, that talk to the Usergrid service.

##Installation

First we'll create a new Rackspace server instance:

####Note: Usergrid needs a bit more memory than your average rails server, so we'll need to pass a `flavor_id` to the command

    rumm create server --name usergrid-server --flavor_id 3

      --> bootstrapping server usergrid-server
          done.
      created server: usergrid-server
        id: 09cdb2a2-0266-41be-bbb-2b031d258b5b, password: iLbUhhh8F98D

Then we'll setup usergrid on the server:

    rumm install usergrid on server usergrid-server

      Setting up a chef kitchen in order to install usergrid on your server.
      This could take a while....

      etc..
      usergrid installed on server usergrid-server: 192.237.240.111

This process will take about 10 minutes.

##Setup

The next step is to initialize the Cassandra database:

    rumm initialize db on usergrid server usergrid-server
      Initializing cassandra database...
      {
        "action" : "cassandra setup",
        "status" : "ok",
        "timestamp" : 1384362059196,
        "duration" : 170
      }
      cassandra database initialized on Usergrid server usergrid-server: 192.237.240.111

At this point, you can login to the admin portal, reached at this URL:

    http://apigee.github.com/usergrid-portal/?api_url=http://<your IP address>:8080

      http://apigee.github.com/usergrid-portal/?api_url=http://192.237.240.111:8080
You can login with either the default Usergrid credentials (user:admin pw:admin_pass) or the user created by the `create organization` command below.

Then Usergrid requires us to create an Organization on the server. This is the top of the hierarchical tree. Organizations can have many Applications.
This action also creates an admin user for this Organization. None of the fields can accept spaces so all parameters should be written in CamelCase or snake_case.

    rumm create organization on usergrid server usergrid-server --org_name my_organization --admin_username myuser --admin_name MyUser --admin_email myuser@ug.com --admin_password admin_pass
      Creating organization on Usergrid server...
      {
        "action" : "new organization",
        "status" : "ok",
        "data" : {
          "owner" : {
            "applicationId" : "00000000-0000-0000-0000-000000000001",
            "username" : "myuser",
            "name" : "MyUser",
            "email" : "myuser@ug.com",
            "activated" : true,
            "confirmed" : true,
            "disabled" : false,
            "properties" : { },
            "uuid" : "50baaf2a-4c85-11e3-bfb6-bdb84c8fb54e",
            "adminUser" : true,
            "displayEmailAddress" : "MyUser <myuser@ug.com>",
            "htmldisplayEmailAddress" : "MyUser &lt;<a href=\"mailto:myuser@ug.com\">myuser@ug.com</a>&gt;"
          },
          "organization" : {
            "name" : "my_organization",
            "properties" : null,
            "uuid" : "50f8546a-4c85-11e3-ba73-9f97e1961322",
            "passwordHistorySize" : 0
          }
        },
        "timestamp" : 1384362121997,
        "duration" : 1150
      }
      Organization: my_organization
      Admin Name: MyUser
      Admin Username: myuser
      Admin Email: myuser@ug.com
      Admin Password: admin_pass
      Something went wrong:  Response code: 200
      organization created on usergrid server usergrid-server: 192.237.240.111
The default values for this command are:

    --org_name my_organization
    --admin_username my_org_admin
    --admin_name MyOrgAdmin
    --admin_email my_org_admin@usergrid.com
    --admin_password admin_pass
These values largely don't matter. One strategy might be to only pass a custom password and leave the other fields as their defaults.


Now setup an application on the server. An Organization can have multiple Applications, but in our case we only need one.
The Usergrid APIs use the organization and application as parameters to reference the selected application.
You will need to re-enter your `org_name`, `admin_username` and `admin_password` here (if you didn't use the default values) and enter an `app_name`.

    rumm create application on usergrid server usergrid-server --app_name my_application --org_name my_organization --admin_username myuser --admin_password admin_pass
      Creating application on Usergrid server...
      D, [2013-11-13T11:03:02.427162 #25213] DEBUG -- : response.body = {
        "action" : "new application for organization",
        "uri" : "http://localhost:8080/null/null",
        "entities" : [ {
          "uuid" : "73b32b10-4c85-11e3-96a3-9f53c8fea97a",
          "type" : "application",
          "name" : "my_organization/my_application",
          "created" : 1384362180681,
          "modified" : 1384362180681,
          "accesstokenttl" : null,
          "applicationName" : "my_application",
          "organizationName" : "my_organization",
          "metadata" : {
            etc..etc..etc..
          }
        } ],
        "data" : {
          "my_organization/my_application" : "73b32b10-4c85-11e3-96a3-9f53c8fea97a"
        },
        "timestamp" : 1384362180666,
        "duration" : 1135
      }
      Organization name: my_organization
      Application name: my_application
      application created on usergrid server usergrid-server: 192.237.240.111

If you refresh the admin portal, you'll see your Organization and Application have been created.

Now we'll move onto the iOS app.

##Setup iOS App

Clone to repository:

    git clone git@github.com:hayesmp/usergrid-sample-app.git

In order to talk to your new server, we need to set 3 parameters in AppDelegate.h

    NSString* const orgName = @"my_organization"; //YOUR-ORG
    NSString* const appName = @"my_application"; //YOUR-APP
    NSString* const nodeUrl = @"http://192.237.240.111:8080"; //BASE-URL

And that's it. On the login/register screen, fill in your Name, Email and Password and click register.

####Note: for some reason, this app won't run in the simulator, so you'll have to replace the development provisioning profile with your own.

The way the app works is that it simpy sends your location with your name as the label to your usergrid server and marks the location on your current map view.

If you click the refresh button, the app will download all the locations on the servers created by other users or you during other sessions.

####A note about Usergrid: Even though you haven't actually create this `location` object on the server, the model is created the first time the data object is sent to the server. Assuming data conformity, all subsequent data can be queried as a group.