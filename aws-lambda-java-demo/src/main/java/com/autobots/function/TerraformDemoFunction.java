package com.autobots.function;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class TerraformDemoFunction implements RequestHandler<String, String> {

    @Override
    public String handleRequest(String input, Context context) {

        String message = "Hello " + input + "!, from Terraform deployed AWS Lambda java function.";

        LambdaLogger logger = context.getLogger();
        logger.log(message);

        return message;
    }
}
