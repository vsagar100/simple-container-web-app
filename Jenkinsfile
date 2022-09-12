pipeline
{
	agent{
		label 'maven-build-server'
	}//agent	
	options{
		buildDiscarder logRotator(numToKeepStr: '10')
	}//options
	tools{
		maven 'maven_server'
	}//tools
	environment{
		GIT_CRED_ID = 'git_cred_simple_web_app' //credentials('git_simple_web_app_user')
		gitRepoUrl = "https://github.com/vsagar100/simple-container-web-app.git"
		gitBranch = "main"
		ARTI_SERVER_ID= "JFrog-artifactory"
		DOCKER_DNS = "ludck00la.centralindia.cloudapp.azure.com"
	}//environment
	stages{
		stage('Git Clone')
		{
			steps{
				git credentialsId: "${GIT_CRED_ID}", url: "${gitRepoUrl}", branch: "${gitBranch}"
			}//steps
		}//stage git-clone
		stage('Build')
		{
			steps{
				script{
					sh "mvn clean package sonar:sonar -Dsonar.login=ccff898f9b726fe1ae2e72d22639788cc680018c"
				}//script
			}//steps sh
		}//stage build	
		stage('Copy Artifacts to Docker')
		{
			steps{
				script{
					sh 'scp Dockerfile dockeruser@"${DOCKER_DNS}":~'
					sh 'scp target/simple-container-web-app-1.0.0.war dockeruser@"${DOCKER_DNS}":~'
					sh 'scp -r target/simple-container-web-app-1.0.0 dockeruser@"${DOCKER_DNS}":~'
				}//script
			}//steps sh
		}//copy artifacts to docker
		
		stage('Build & Run Docker Image')
		{
			steps{
				script{
					def dockerRun= "whoami && \
							docker build . -f Dockerfile -t vsagar100/simple-container-web-app && \
							docker run -dit -p 8585:8080 --name=mytomcat vsagar100/simple-container-web-app && \
							docker cp /home/azureuser/code/simple-container-web-app/target/simple-container-web-app-1.0.0 mytomcat:/usr/local/tomcat/webapps/"
				//	sshagent(credentials: ['dockeruser']) {
						// some block
					sh "ssh -o strictHostKeyChecking=no dockeruser@'${DOCKER_DNS}' '${dockerRun}'"
				//	}//sshagent
				
			//sshPublisher(publishers: [sshPublisherDesc(configName: 'ludck00la.centralindia.cloudapp.azure.com', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '${dockerRun}', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '*.war')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])

			
			
			//sh "docker run -dit -p 5001:8080 --entrypoint=/bin/bash  vsagar100/simple-container-web-app"
			//docker run -itd --rm -p 5000:8080 --entrypoint=/bin/bash tomcat:9-jre11
				}//script
			}//steps def docker
		}//stage Docker
		
	}//stages
	

	
}//pipeline
