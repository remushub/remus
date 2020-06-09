node {
	
	def app
	
	stage('Clone Repository') {
		checkout scm
	}
	
	stage('Build image') {
		app = docker.build("remushub/aspnet-build")
	}
	
	stage('Test') {
		app.inside('-p 8000:80') {
			//sh 'dotnet /app/Remus/out/Remus.dll'
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