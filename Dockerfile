# Use your custom Tomcat base image
FROM iamdevopstrainer/tomcat:base

# (Optional) clean out any default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR into Tomcat’s webapps directory
# Make sure this matches the artifact name exactly
COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Expose Tomcat’s HTTP port
EXPOSE 8080

# Launch Tomcat in the foreground
CMD ["catalina.sh", "run"]
