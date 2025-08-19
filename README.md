# Backstage Template for Terraform Integration

An example showing how a Backstage Software Template can be used to trigger a Run in Terraform that creates an S3 Bucket in AWS.

## Setup

1. Setup a Terraform account, organisation, and workspace.
1. Fork this repository and update the default values for the hidden variables in the _template.yaml_ to match your Terraform organisation, workspace name, and workspace ID.
1. Import your fork of this repository into your Terraform workspace using _Settings > Version Control_.
1. Import your forked _template.yaml_ into your Backstage instance.
1. Obtain a Terraform API token from your user settings page - you'll need it in the next step.
1. Configure your Backstage `proxy` like so:
    ```yaml
    proxy:
      reviveConsumedRequestBodies: true
      followRedirects: true
      endpoints:
        '/tfc':
          target: https://app.terraform.io/api/v2
          headers:
            # Inject your TFC API token at the proxy so it never lives in the template
            Authorization: Bearer ${TFC_TOKEN}
            # TFC endpoints expect JSON:API content-type
            Content-Type: application/vnd.api+json
          # Increase if your runs or large responses need longer
          timeout: 60000
    ```
1. Add the [Roadie HTTP Request plugin](https://github.com/RoadieHQ/roadie-backstage-plugins/tree/main/plugins/scaffolder-actions/scaffolder-backend-module-http-request) to your Backstage instance.
1. Add the [Roadie Scaffolder Utils plugin](https://www.npmjs.com/package/@roadiehq/scaffolder-backend-module-utils) to your Backstage instance.
1. Configure a `TFC_TOKEN` variable to hold the API token for your Terrafrom account and make it available to Backstage using an environment variable.

Once you've completed these steps you'll be able to run the Software Template from Backstage.
