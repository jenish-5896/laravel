pipeline {
    agent {
        label 'controllerNode'
    }
    stages {
        stage('Build Application') {
            steps {
                sh ''' 
                docker-compose up -d
                php artisan key:generate
                php artisan config:cache
                sh '''
            }
        }
    }
}
