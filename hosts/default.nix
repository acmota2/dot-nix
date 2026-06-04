{ hostname, ... }:
{
  imports = [ ./hostnames/${hostname}.nix ];
}
