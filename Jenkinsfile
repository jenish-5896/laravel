pipeline {
    agent {
        label 'myslaveNode'
    }
    stages {
        stage('Build Application') {
            steps {
                sh ''' 
                docker-compose up -d
                sh '''
            }
        }
    }
}
