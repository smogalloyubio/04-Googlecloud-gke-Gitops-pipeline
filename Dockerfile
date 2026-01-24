# 1. Use the official Google Cloud SDK base
FROM google/cloud-sdk:slim

# 2. Install dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    software-properties-common \
    wget \
    curl \
    apt-transport-https \
    ca-certificates

# 3. Add HashiCorp Repository (for Terraform)
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list

# 4. Add Google Cloud SDK Repository (Explicitly for the plugin)
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/cloud.google.gpg > /dev/null

# 5. Install Terraform and the GKE Auth Plugin (using correct name)
RUN apt-get update && apt-get install -y \
    terraform \
    google-cloud-sdk-gke-gcloud-auth-plugin \
    kubectl

# 6. Set environment variable so kubectl knows to use the plugin
ENV USE_GKE_GCLOUD_AUTH_PLUGIN=True

WORKDIR /workspace
CMD ["/bin/bash"]