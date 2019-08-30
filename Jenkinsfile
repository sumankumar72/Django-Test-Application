def proj_name = "Test"


node {

    try {

        stage 'Checkout'
            checkout scm
        stage 'Deploy'
            print 'Deploy Done'
        stage 'Publish'
            print 'Publish Done'
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