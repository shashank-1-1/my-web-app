FROM jenkins/jenkins:lts

USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl tar python3 python3-pip python3-venv && \
    curl -LO https://github.com/openshift/okd/releases/download/4.15.0-0.okd-2024-03-10-010116/openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    tar -xvf openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    mv oc /usr/local/bin/oc && \
    chmod +x /usr/local/bin/oc && \
    rm openshift-client-linux-4.15.0-0.okd-2024-03-10-010116.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins

# Set working directory for the Python application
WORKDIR /app

# Copy Python application files into the container
COPY src/main/python/ ./

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    ./venv/bin/pip install --no-cache-dir -r requirements.txt

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["./venv/bin/python", "app.py"]
