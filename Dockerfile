# Use the Jenkins image as the base image
FROM jenkins/jenkins:lts

# Switch to root user to install additional tools
USER root

# Install necessary tools, including curl and unzip
RUN apt-get update && \
    apt-get install -y curl unzip && \
    curl -LO https://github.com/openshift/okd/releases/download/v4.9.0/openshift-client-windows.zip && \
    unzip openshift-client-windows.zip && \
    mv oc.exe /usr/local/bin/oc && \
    chmod +x /usr/local/bin/oc && \
    rm openshift-client-windows.zip && \
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
