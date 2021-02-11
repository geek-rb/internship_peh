node {
    def IMAGE_NAME = "task4-7/id-$BUILD_NUMBER"

    stage('Prepare') {
//        cleanWs deleteDirs: true
        echo ' Prepare...'
    }

    stage('get reps') {
        git credentialsId: 'user-pass-github', url: 'https://github.com/geek-rb/test-jenkins'
    }

    stage('Build') {
        if (fileExists('Dockerfile')) {
            echo 'DOCKERFILE exist, begin build'
            withCredentials([string(credentialsId: 'secret-pass', variable: 'T5')]) {
              sh "docker build --build-arg PASSWORD=${T5} -t ${IMAGE_NAME} ."
              echo "${IMAGE_NAME}"
                    }
        } else {
            echo 'No DOCKERFILE!'
        }
                  }
    stage('Test') { 
        def TEST_KEY = sh (
            script: "docker image inspect ${IMAGE_NAME} | grep PASSWORD=",
            returnStdout: true
            ).trim()
        echo "If you view pass in text bellow - test passed ;) : ${TEST_KEY}"
        }
    
}