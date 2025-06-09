pipeline {
    agent {
        label 'node1'
    }

    stages {
        stage('Clone GitHub Repo') {
            steps {
                git url: 'https://github.com/dhanushvaddi/jenkins-pipeline-git-clone', branch: 'main'
                sh 'ls -l'
            }
        }
    }

    post {
        success {
            echo 'Repository cloned successfully on Node1.'
        }
        failure {
            echo 'Failed to clone repository.'
        }
    }
}
