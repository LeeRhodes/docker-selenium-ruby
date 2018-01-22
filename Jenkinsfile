podTemplate(label: 'docker-builder', cloud: 'kubernetes', namespace: 'jenkins-helm', containers: [
    containerTemplate(
        name: 'docker', // named jnlp so you can override standard image
        image: 'docker',
        ttyEnabled: true,
        privileged: false,
        alwaysPullImage: false,
        workingDir: '/home/jenkins'
    ),
],
volumes: [
    hostPathVolume(mountPath: '/home/jenkins/workspace/', hostPath: '/home/jenkins/workspace/'), // had to mount for app.inside
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
]) {
node('docker-builder') {
    
    checkout scm

    stage ('test') {
        def app = docker.image('golang:rc-alpine')
            container('docker') {
                app.pull()
            }
        app.inside {
            sh 'ls -alh'
        }
    }
}
}