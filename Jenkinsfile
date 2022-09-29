    node("docker-stage") {
    checkout scm

    stage("Staging") {
      try {
        sh "docker stack deploy --compose-file=${WORKSPACE}/swarm-app/docker-compose.yml swarm-app-test"

      } catch(e) {
        error "Staging failed"
      } finally {
        sh "docker stack rm swarm-app-test"
      }
    }
  }
  
  node("docker-prod") {
    checkout scm
    
    stage("Production") {
      try {
        sh '''
            docker network rm docker-swarm-app || true
            docker network create --driver overlay --attachable docker-swarm-app
            docker stack deploy --compose-file=${WORKSPACE}/swarm-app/docker-compose.yml swarm-app
          '''
      }catch(e) {
        error "Service update failed in production"
      }finally {
        sh '''
            docker service scale swarm-app_redis01=3 || true
            docker service scale swarm-app_results-app=3 || true
            docker service scale swarm-app_vote-worker=3 || true
            docker service scale swarm-app_web-vote-app=3 || true
          '''
      }
    }
  }