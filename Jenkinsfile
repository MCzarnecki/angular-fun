node {
    currentBuild.result = "SUCESS"

    try {
        stage('Checkout') {
          deleteDir()
          checkout scm
        }

        stage('Run protractor tests') {
            dir('angular-fun') {
                sh 'docker run -it --privileged --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor webnicer/protractor-headless e2e/protractor.conf.js'
            }
        }

    } catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }
}