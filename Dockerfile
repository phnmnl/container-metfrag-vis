FROM container-registry.phenomenal-h2020.eu/phnmnl/metfrag-cli:latest

LABEL software.version=0.1
LABEL version=0.1
LABEL software=metfrag-vis

MAINTAINER PhenoMeNal-H2020 Project ( phenomenal-h2020-users@googlegroups.com )

LABEL Description="MetFrag results visualization."

# Update & upgrade sources
RUN apt-get -y update

# Install development files needed
RUN apt-get -y install maven texlive-latex-base git openjdk-8-jdk-headless texlive-fonts-recommended

# Clean up
RUN apt-get -y clean && apt-get -y autoremove && rm -rf /var/lib/{cache,log}/ /tmp/* /var/tmp/*

# Install MetFrag
RUN git clone https://github.com/c-ruttkies/ConvertMetFragCSV.git && cd ConvertMetFragCSV && mvn clean install -am && mv target/ConvertMetFragCSV-*-jar-with-dependencies.jar /usr/local/bin/ConvertMetFragCSV.jar 

ADD scripts/* /usr/local/bin/

RUN chmod +x /usr/local/bin/*

# add test case
ADD runTest1.sh /usr/local/bin/runTest1.sh
RUN chmod +x /usr/local/bin/runTest1.sh

# Define Entry point script
