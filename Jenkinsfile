pipeline {
    agent {
        label 'myslaveNode'
    }
    stages {
        stage('Build Application') {
            steps {
                sh ''' 
                docker-compose up -d
                docker exec app php artisan key:generate
                docker exec app php artisan config:cache
                sh '''
            }
        }
    }
}
