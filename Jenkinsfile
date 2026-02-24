pipeline {
    agent any

    environment {
        OPENSHIFT_SERVER = "https://api.rm3.7wse.p1.openshiftapps.com:6443"
        PROJECT = "sabbavarapu-satish-0-dev"
        APP_NAME = "enterprise-clean"
    }

    stages {

        stage('Git Checkout Code') {
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

        stage('Trigger OpenShift Build') {
            steps {
                bat '''
                    oc start-build %APP_NAME% --follow
                '''
            }
        }
	
	stage('Tag Image') {
	    steps {
                bat '''
                    oc tag enterprise-clean:latest enterprise-clean:%BUILD_NUMBER%
                '''
            }
        }

        stage('Verify Rollout') {
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
