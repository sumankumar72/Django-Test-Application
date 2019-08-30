def proj_name = "Test"


node {

    try {

        stage 'Checkout'
            slackSend color: "good", message: "Checkout : ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful"
            checkout scm
        stage 'Deploy'
            print 'Deploy Done'
            slackSend color: "good", message: "Deploy : ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful"
        stage 'Publish'
            print 'Publish Done'
            slackSend color: "good", message: "Publish : ${env.JOB_NAME} with buildnumber ${env.BUILD_NUMBER} was successful"
    }
    catch (err) {

        def exp_error = err.toString()
        if (!exp_error.contains('-STOP-'))
        {
            print exp_error
        }
        throw err
    }
}
