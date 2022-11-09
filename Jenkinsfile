pipeline {
    agent {
        label 'controllerNode'
    }
    stages {
        stage('Build Application') {
            steps {
                sh ''' 
                sudo docker-compose up -d
                sudo php artisan key:generate
                sudo php artisan config:cache
                sh '''
            }
        }
    }
}
