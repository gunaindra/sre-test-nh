  env.DOCKERHUB_USERNAME = 'sbikram'

//   node("docker-test") {
//     checkout scm

//     stage("Unit Test") {
//       sh "docker run --rm -v ${WORKSPACE}:/go/src/docker-ci-cd golang go test docker-ci-cd -v --run Unit"
//     }
//     stage("Integration Test") {
//       try {
//         sh "docker build -t docker-ci-cd ."
//         sh "docker rm -f docker-ci-cd || true"
//         sh "docker run -d  -p 9098:8080 --name=docker-ci-cd docker-ci-cd"
//         // env variable is used to set the server where go test will connect to run the test
//         sh "docker run --rm -v ${WORKSPACE}:/go/src/docker-ci-cd --link=docker-ci-cd -e SERVER=docker-ci-cd golang go test docker-ci-cd -v --run Integration"
//       }
//       catch(e) {
//         error "Integration Test failed"
//       }finally {
//         sh "docker rm -f docker-ci-cd || true"
//         sh "docker ps -aq | xargs docker rm || true"
//         sh "docker images -aq -f dangling=true | xargs docker rmi || true"
//       }
//     }
//     stage("Build") {
//       sh "docker build -t ${DOCKERHUB_USERNAME}/docker-ci-cd:${BUILD_NUMBER} ."
//     }
//     stage("Publish") {
//       withDockerRegistry([credentialsId: 'DockerHub']) {
//         sh "docker push ${DOCKERHUB_USERNAME}/docker-ci-cd:${BUILD_NUMBER}"
//       }
//     }
//   }

//   node("docker-stage") {
//     checkout scm

//     stage("Staging") {
//       try {
//         sh "docker rm -f docker-ci-cd || true"
//         sh "docker run -d -p 9098:8080 --name=docker-ci-cd ${DOCKERHUB_USERNAME}/docker-ci-cd:${BUILD_NUMBER}"
//         sh "docker run --rm -v ${WORKSPACE}:/go/src/docker-ci-cd --link=docker-ci-cd -e SERVER=docker-ci-cd golang go test docker-ci-cd -v"

//       } catch(e) {
//         error "Staging failed"
//       } finally {
//         sh "docker rm -f docker-ci-cd || true"
//         sh "docker ps -aq | xargs docker rm || true"
//         sh "docker images -aq -f dangling=true | xargs docker rmi || true"
//       }
//     }
//   }

  node("docker-prod") {
    stage("Production") {
      try {
        // Create the service if it doesn't exist otherwise just update the image
        sh '''
            docker network rm docker-swarm-app || true
            docker network create --driver overlay --attachable docker-swarm-app
            docker stack deploy --compose-file=swarm-app/docker-compose.yml swarm-app
          '''
      }catch(e) {
        error "Service update failed in production"
      }finally {
        sh "docker ps -aq | xargs docker rm || true"
      }
    }
  }