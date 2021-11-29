# Please refer to the documentation:
# https://cloud.google.com/migrate/anthos/docs/dockerfile-reference
FROM anthos-migrate.gcr.io/v2k-run-embedded:v1.9.0 as migrate-for-anthos-runtime

# Image containing data captured from the source VM
FROM gcr.io/eitane-test/petclinic-springboot-non-runnable-base:11-24-2021--11-0-44 as source-content

ARG WAR_FILE=WAR_FILE_MUST_BE_SPECIFIED_AS_BUILD_ARG

COPY --from=migrate-for-anthos-runtime / /

ADD blocklist.yaml /.m4a/blocklist.yaml

ADD logs.yaml /code/config/logs/logsArtifact.yaml


ADD services-config.yaml /.m4a/


# If you want to update parts of the image, add your commands here.
# For example:
# RUN apt-get update
# RUN apt-get install -y \
#               package1=version \
#               package2=version \
#               package3=version
# RUN yum update
# RUN wget http://github.com

COPY --chown=root:root ${WAR_FILE} /opt/tomcat/webapps/

# Migrate for Anthos image includes entrypoint
ENTRYPOINT [ "/.v2k.go" ]

