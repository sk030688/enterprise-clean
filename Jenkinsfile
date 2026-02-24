pipeline {
    agent any

    parameters {
        booleanParam(name: 'ROLLBACK', defaultValue: false, description: 'Rollback deployment')
    }

    environment {
        OPENSHIFT_SERVER = "https://api.rm3.7wse.p1.openshiftapps.com:6443"
        PROJECT = "sabbavarapu-satish-0-dev"
        APP_NAME = "enterprise-clean"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Login to OpenShift') {
            steps {
                withCredentials([string(credentialsId: 'openshift-token', variable: 'TOKEN')]) {
                    bat '''
                        oc login --token=%TOKEN% --server=%OPENSHIFT_SERVER%
                        oc project %PROJECT%
                    '''
                }
            }
        }

        stage('Rollback Option') {
            when {
                expression { return params.ROLLBACK == true }
            }
            steps {
                bat '''
                    oc rollout undo deployment/%APP_NAME%
                '''
            }
        }

        stage('Trigger OpenShift Build') {
            when {
                expression { return params.ROLLBACK == false }
            }
            steps {
                bat '''
                    oc start-build %APP_NAME% --follow
                '''
            }
        }

        stage('Approval') {
            when {
                expression { return params.ROLLBACK == false }
            }
            steps {
                input message: "Deploy to production?"
            }
        }

        stage('Verify Rollout') {
            when {
                expression { return params.ROLLBACK == false }
            }
            steps {
                bat '''
                    oc rollout status deployment/%APP_NAME%
                '''
            }
        }
    }

    post {
        success {
            echo "Enterprise CI/CD Success 🚀"
        }
        failure {
            echo "Pipeline Failed ❌"
        }
    }
}
