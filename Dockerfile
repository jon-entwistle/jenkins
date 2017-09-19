FROM jenkins/jenkins:alpine

ENV TIMESTAMP 20170917
ENV VERSION 0.9

# For jenkins backup script
USER root
RUN apk add --no-cache rsync
USER jenkins
# Whether to skip setup wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Creates username and password specified through environment variables JENKINS_USER_SECRET and JENKINS_PASS_SECRET
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

# Enable and configure role-strategy plugin, by default admin user for admin privileges
COPY role-strategy.groovy /usr/share/jenkins/ref/init.groovy.d/role-strategy.groovy

# Install a list of plugins with their dependencies on Jenkins master
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

