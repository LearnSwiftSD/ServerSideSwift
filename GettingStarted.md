# Getting Started With Vapor

Okay, let's get some of the prerequisites of using [Vapor](https://vapor.codes)
out of the way. You can do this from start to finish with either a Linux or a
Mac, but for the sake of brevity, we'll be doing this from the perspective of
the MacOS user. Much of Vapor and Server Side Swift development is done via
the command line so you'll need to open up the Terminal app.
___
## Installation

### - Run The Checklist

This will run a compatibility check to verify that we have the proper versions
of Xcode and Swift required to work with vapor. If you find that something doesn't
make the checklist, make sure to upgrade or install the appropriate version. Enter:
```sh
eval "$(curl -sL check.vapor.sh)"
```

### - Homebrew Package Manager

You'll need to be able to install Vapor. To do that I like to use the vastly
popular [HomeBrew](https://brew.sh) package manager. If you haven't installed
that before, go to your Terminal and enter:
```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### - Vapor CLI

Next, install Vapor's toolbox, which allows you to do many of the commands
necessary to build, run, and develop Server Side Swift projects. In your
Terminal enter:
```sh
brew tap vapor/homebrew-tap
brew update
brew install vapor
```

In the future, if you'd like to make sure that your version of Vapor is up
to date you can enter:
```sh
brew upgrade vapor/tap/vapor
```

You can check that Vapor's CLI was installed properly by running the help command
, which will produce a quick list of the commands available:
```sh
vapor --help
```
___
## Start a Vapor Project

Now that you've got all the tools ready to create your own Vapor project, let's
go over how to actually create one. If you're an iOS dev, you'll need to fight
the urge to head over to your Xcode app when it comes to creating Server Side
stuff. With Vapor, your Xcode projects are ephemeral, meaning that they get
discarded and reproduced every time you open it. That being said, how do we
start a project? Well, from the command line of course!

### - New Vapor Project

Vapor, like Xcode, provides various templates depending on the type of Server
Side project you're looking to build. You can specify one of the official Vapor
templates or you can use one produced by members in the community. To do this
you use Vapor's `new` command followed by the appropriate template tag. Here are
a couple of examples:

- `vapor new <ProjectName> --web`  *For building web apps*
- `vapor new <ProjectName> --auth`  *For building an authenticated web api*
- `vapor new <ProjectName> --api`  *For building a regular web api*
- `vapor new <ProjectName> --template=<TemplateName>`  *For specifying a custom template.*

### - Other Vapor Commands

While this can be accomplished with Xcode it's nice to know that it's not needed.
Use the build command at the project directory to build the Vapor project.

- `vapor build` 

To run the project from the command line, you can use the run command. To 
stop the running server use the combined keys "cntrl + C". 

- `vapor run` 

The last of the commands that we'll cover is the xcode command. You don't need
Xcode to run, build, or edit your Vapor projects, but being that Xcode is rich with
features for developing in Swift, it sure is nice to use. To generate an Xcode project
enter:

- `vapor xcode -y`

*Remember to use this command any time you want to open your project*

___
## HTTP tool for REST APIs

You can use you're favorite HTTP tool either from the command line or in a GUI.
If you'd like to follow along with the specific tool we'll be using, you can download it
for free from this [itunes site](https://itunes.apple.com/us/app/rested-simple-http-requests/id421879749?mt=12).
It's called [RESTed](http://www.helloresolven.com/portfolio/rested/) and is a very easy 
to use GUI that allows us to make HTTP requests to our server.

**Looking forward to writing Server Side Swift with you! 👋**
