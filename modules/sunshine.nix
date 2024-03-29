{ pkgs, ... }:
{
  systemd.user.services = {
    sunshine = {
      Unit.Description = "Sunshine is a Game stream host for Moonlight.";
      Service.ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
