node {
    stage('Prepare') {
//        cleanWs deleteDirs: true
    }
    
    stage('get reps') {
        git credentialsId: 'user-pass-github', url: 'https://github.com/geek-rb/test-jenkins'
    }
    
    stage('Build') {

        if (fileExists('Dockerfile')) {
            echo 'DOCKERFILE exist, begin build'
            withCredentials([string(credentialsId: 'secret-pass', variable: 't5')]) {
              sh "docker build --build-arg PASSWORD=${t5} -t task4-7/id-$BUILD_NUMBER ."  
                    }
        } else {
            echo 'No DOCKERFILE!'
        }

                  }
}