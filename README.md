Perseus
====

A simple set of scripts - and Dockerfile, to easily maintain and run a very light image of the latests Fedora system for the sole purpose of running Wildfly AS local build (but could run, in fact, anykind of Java-based Maven build). The main reason beyond this automation is that Wildfly build (mvn clean install) fires up instance of an app server binding on a local port - which make it uneasy to fire several build, on the same system, at the same time. With the scripts provided with this project, you can easily wrap around the build into a container.

How to
====

1) Build the Docker Image

To build the image, simply run the 'build-docker-image.sh' script - it will build the Docker image
used by the next script.

    $ ./build-docker-image.sh

2) Launch the container:

    $ ./docker-build.sh <path-to-project-repo>


This will fire a docker instance, with the project *mounted* on it along with the required mvn (MAVEN_HOME) and java (JAVA_HOME) folder.

Ex:

    rpelisse@tiberius perseus.git (master)]$ ./docker-build.sh ~/Repositories/redhat/issues/JBEAP-6449/wildfly.git/
    builder@builder ~]$ java -version
    openjdk version "1.8.0_111"
    OpenJDK Runtime Environment (build 1.8.0_111-b16)
    OpenJDK 64-Bit Server VM (build 25.111-b16, mixed mode)
    builder@builder ~]$ mvn -version
    Apache Maven 3.3.9 (bb52d8502b132ec0a5a3f4c09453c07478323dc5; 2015-11-10T16:41:47+00:00)
    Maven home: /maven
    Java version: 1.8.0_111, vendor: Oracle Corporation
    Java home: /java/jre
    Default locale: en_US, platform encoding: ANSI_X3.4-1968
    OS name: "linux", version: "4.8.12-200.fc24.x86_64", arch: "amd64", family: "unix"
    builder@builder ~]$ mvn clean install
    [INFO] Scanning for projects...
    Downloading: http://repository.jboss.org/nexus/content/groups/public/org/jboss/jboss-parent/21/jboss-parent-21.pom
    Downloaded: http://repository.jboss.org/nexus/content/groups/public/org/jboss/jboss-parent/21/jboss-parent-21.pom (36 KB at 45.2 KB/sec)
    Downloading: http://repository.jboss.org/nexus/content/groups/public/org/wildfly/core/wildfly-core-parent/3.0.0.Alpha15/wildfly-core-parent-3.0.0.Alpha15.pom
    Downloaded: http://repository.jboss.org/nexus/content/groups/public/org/wildfly/core/wildfly-core-parent/3.0.0.Alpha15/wildfly-core-parent-3.0.0.Alpha15.pom (76 KB at 142.7 KB/sec)
    Downloading: http://repository.jboss.org/nexus/content/groups/public/org/wildfly/arquillian/wildfly-arquillian-parent/2.0.0.Final/wildfly-arquillian-parent-2.0.0.Final.pom
    Downloaded: http://repository.jboss.org/nexus/content/groups/public/org/wildfly/arquillian/wildfly-arquillian-parent/2.0.0.Final/wildfly-arquillian-parent-2.0.0.Final.pom (22 KB at 53.5 KB/sec)
    Downloading: http://repository.jboss.org/nexus/content/groups/public/org/jboss/jboss-parent/19/jboss-parent-19.pom:


This project is called 'perseus' as a reference to the Greek Mythology character, as the JBoss SET team is using Greek divinities for its project names as a convention:

https://en.wikipedia.org/wiki/Perseus

Troubleshooting
====

* SELinux does not allow Docker to mount file system (or at least not anyone) - so run without SELinux disabled (but at your own peril !)
** I would love to see a command or a SE policy to workaround that being contributed :)
* MAVEN_HOME is expected to be self contained (ie unzip from an archive) - so check that your MAVEN is not the one provided by the system (so no '$ yum install maven')

