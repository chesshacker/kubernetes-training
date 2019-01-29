FROM alpine:3.8

ENV TERRAFORM_VERSION="0.11.11" \
    KUBERNETES_VERSION="1.13.2" \
    HELM_VERSION="2.12.3" \
    CLOUD_SDK_VERSION="231.0.0"

# Install dependencies
RUN apk update && \
    apk add \
      curl \
      py-pip \
      python \
      docker \
      git \
      openssh \
      jq \
      openssl \
    && rm -rf /var/cache/apk/*

# Install Terraform
RUN ( cd /tmp && \
      curl -sLo terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
      unzip terraform.zip && \
      rm terraform.zip && \
      mv ./terraform /usr/local/bin \
    ) && terraform --version

# Install Kubernetes
RUN ( cd /tmp && \
      curl -sLo kubernetes.tar.gz "https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/kubernetes-client-linux-amd64.tar.gz" && \
      tar -xzf kubernetes.tar.gz && \
      mv kubernetes/client/bin/kubectl /usr/local/bin && \
      rm -R kubernetes.tar.gz kubernetes \
    ) && kubectl version --client --short

# Install Helm
RUN ( cd /tmp && \
      curl -sLo helm.tar.gz "http://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz" && \
      tar -xzf helm.tar.gz && \
      mv linux-amd64/helm /usr/local/bin && \
      rm -R helm.tar.gz linux-amd64 \
    ) && helm version --client --short

#Configure paths
ENV PATH="/usr/local/google-cloud-sdk/bin:$PATH"

# Install Google Cloud SDK
RUN ( cd /tmp && \
      curl -sLo gcloud-sdk.tar.gz "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" && \
      tar xzf gcloud-sdk.tar.gz && \
      rm gcloud-sdk.tar.gz && \
      mv google-cloud-sdk /usr/local && \
      ln -s /lib /lib64 \
    ) && gcloud version && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud components install beta

# Install Jinja2 and docker-compose and add b64 filtering to jinja-cli
RUN pip install --upgrade pip && \
    pip install jinja2-cli[yaml] docker-compose yq && \
    sed -i "s/os.environ.get/os.environ.get\n    import base64\n    env.filters['b64encode'] = base64.b64encode\n    env.filters['b64decode'] = base64.b64decode\n/" \
    /usr/lib/python2.7/site-packages/jinja2cli/cli.py

WORKDIR /app

CMD ["sh"]
