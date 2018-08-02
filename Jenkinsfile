node {
    currentBuild.result = "SUCESS"

    try {
        stage('Checkout') {
          deleteDir()
          checkout scm
        }

        stage('Run protractor tests') {
            sh 'docker run -it --privileged --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor webnicer/protractor-headless e2e/protractor.conf.js'
        }

    } catch (err) {

        currentBuild.result = "FAILURE"

            mail body: "project build error is here: ${env.BUILD_URL}" ,
            from: 'mich.czarnecki@o2.pl',
            subject: 'project build failed',
            to: 'mich.czarnecki@o2.pl'

        throw err
    }
}