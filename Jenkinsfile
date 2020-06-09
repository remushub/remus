node {
	
	def app
	
	stage('Clone Repository') {
		checkout scm
	}
	
	stage('Build image') {
		app = docker.build("remushub/aspnet-build").withRun('-p 8000:80')
	}
	
	stage('Test') {
		app.inside {
			sh 'sleep 300'
		}
	}
	
	stage('Approval') {
		timeout(time: 1, unit: 'HOURS') {
			input 'Upload to Docker Hub?'
		}
	}
	
	
	stage('Push image') {
		docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
			app.push('latest')
		}
	}
}