{ ... }:

{
  programs.awscli = {
    enable = true;
    settings = {
      "profile deployment-power-user" = {
        sso_session = "txm";
        sso_account_id = "919093400542";
        sso_role_name = "TXM-CDO-Prod-PowerUser";
        region = "us-east-1";
        output = "json";
      };
      "profile dev-power-user" = {
        sso_session = "txm";
        sso_account_id = "193322884577";
        sso_role_name = "TXM-CDO-Prod-PowerUser";
        region = "us-east-1";
        output = "json";
      };
      "profile sandbox-power-user" = {
        sso_session = "txm";
        sso_account_id = "282903250829";
        sso_role_name = "TXMSandboxPowerUser";
        region = "us-east-1";
        output = "json";
      };
      "sso-session txm" = {
        sso_start_url = "https://txm.awsapps.com/start#/";
        sso_region = "us-east-1";
        sso_registration_scopes = "sso:account:access";
      };
    };
  };
}
