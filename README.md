# sinatra-jira
This is an template for an application to submit bugs to JIRA. This script uses [basic authentication](https://developer.atlassian.com/server/jira/platform/basic-authentication/), but you can easily alter it to use [OAuth](https://developer.atlassian.com/server/jira/platform/oauth/) instead. If using this, you'll also want to update `views/response.erb` to reflect whatever you want users to see after they submit a ticket (ie further instructions).

This is as flexible as the [JIRA API](https://developer.atlassian.com/server/jira/platform/oauth/). If you want to add more fields, just update `views/form.erb` and `json` in `sinatra_jira.rb`. I would recommend updating the examples to be more specific and relevant to your project.

## getting started

1) `cp .env.example .env`
2) update .env with your JIRA username, password, and project key
2) `bin/setup`
3) `ruby sinatra_jira.rb`
