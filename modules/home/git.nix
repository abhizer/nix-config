{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Abhinav Gyawali";
    userEmail = "22275402+abhizer@users.noreply.github.com";
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };
    extraConfig = {
      commit.signoff = true;
    };
  };
}
