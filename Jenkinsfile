pipeline {
    agent any

    options {
        ansiColor('xterm')
    }
    
    stages {

        stage('clear workspace'){
            steps{
                step([$class: 'WsCleanup'])
            }
        }

        stage('Clone Git Repository') {
            steps {
                sshagent(['Ssh-key']) {
                    git branch: 'main', url: 'git@github.com:AdithyanThevar/Terraform-devops-fullstack.git'
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }    

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=planfile'
            }
        }

        stage("Approval") {
            steps {
                input "Proceed For Deployment"                                                                    
            }
        }  

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve planfile'
            }
        }


        stage('Get Instance ID from Terraform Output') {
            steps {
                script {
                    def instanceIP = sh(script: 'terraform output -raw instance_public_ip', returnStdout: true).trim()
                    env.INSTANCE_IP = instanceIP
                }
            }
        }

        stage('Create Temp HostFile') {
            steps {
                sh """
                cat <<EOF > /tmp/hosts
[test]
${env.INSTANCE_IP}

[test:vars]
ansible_user=ec2-user
ansible_ssh_private_key_file=/opt/jenkins/keys/test-user.key
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOF
                """
            }
        }

        stage('Ansible Playbook for deploying Application') {
            steps {
                sh """
                ansible-playbook -i /tmp/hosts docker-playbook.yml --limit "${env.INSTANCE_IP}" 
                """
            }
        }

    }
}
