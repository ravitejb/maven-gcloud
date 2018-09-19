FROM java:8-jdk

ARG GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-178.0.0-linux-x86_64.tar.gz"

# Create Directory for local artifact repo
RUN mkdir -p /artifact

# Install Maven
RUN curl http://apache.spinellicreations.com/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz -o /maven.tar.gz && \
    tar -xvzf /maven.tar.gz -C / && rm /maven.tar.gz

RUN \
	##################
	# GCLOUD INSTALL #
	##################
	# get the gcloud package
	wget "$GCLOUD_URL" -O gcloud.tar.gz && \
	tar -xf gcloud.tar.gz && \
	mv google-cloud-sdk /opt/ && \
	/opt/google-cloud-sdk/install.sh --quiet && \
	rm -f gcloud.tar.gz

ENV PATH /apache-maven-3.5.4/bin:${PATH}
ENV PATH /opt/google-cloud-sdk/bin:$PATH
USER root
# Define default command.
CMD ["bash"]
