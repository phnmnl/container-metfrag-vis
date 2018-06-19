FROM ubuntu:16.04

LABEL software.version=0.4.1
LABEL version=0.5
LABEL software=metfrag-vis

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="MetFrag results visualization."

# Update & upgrade sources
RUN apt-get -y update

# Install development files needed
RUN apt-get -y install maven texlive-latex-base git openjdk-8-jdk-headless texlive-fonts-recommended openjdk-8-jre-headless wget

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Install MetFrag
RUN git clone https://github.com/c-ruttkies/ConvertMetFragCSV.git && cd ConvertMetFragCSV && mvn clean install -am && mv target/ConvertMetFragCSV-*-jar-with-dependencies.jar /usr/local/bin/ConvertMetFragCSV.jar 
RUN wget https://msbi.ipb-halle.de/~cruttkie/metfrag/MetFrag2.4.5-Tools.jar && mv MetFrag2.4.5-Tools.jar /usr/local/bin/MetFrag-Tools.jar

RUN apt-get -y purge git maven openjdk-8-jdk-headless

ADD scripts/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*

# add test case
ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod +x /usr/local/bin/runTest1.sh

# Define Entry point script
