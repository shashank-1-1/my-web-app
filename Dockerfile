# Use the Jenkins image as the base image
FROM jenkins/jenkins:lts

# Switch to root user to install additional tools
USER root

# Install necessary tools, including curl and tar
RUN apt-get update && \
    apt-get install -y curl tar && \
    curl -LO https://github.com/openshift/okd/releases/download/4.15.0-0.okd-2024-03-10-010116/openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    tar -xvf openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    mv oc /usr/local/bin/oc && \
    chmod +x /usr/local/bin/oc && \
    rm openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the Jenkins user
USER jenkins

# Set working directory for the Python application
WORKDIR /app

# Copy Python application files into the container
COPY src/main/python/ ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt 

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]
