{ home-manager, username, ...}:
{
    home-manager.users.${username} = _: {
        programs.enable
    }
}
