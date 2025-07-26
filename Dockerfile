FROM ubuntu:20.04

# Set non-interactive environment variables for tzdata
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    software-properties-common \
    curl \
    jq \
    sshpass \
    python3-pip \
    && apt-add-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible \
    && apt-get clean \
    && pip3 install pywinrm
WORKDIR /ansible
COPY run_ansible.sh /ansible/run_ansible.sh
COPY playbook.yml /ansible/playbook.yml
COPY roles/ /ansible/roles/
RUN chmod +x /ansible/run_ansible.sh
ENTRYPOINT ["/ansible/run_ansible.sh"]
