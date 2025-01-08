{myvars, ...}: {
    users.users.${myvars.username} = {
        home = "/Users/${myvars.username}";
        name = "${myvars.name}";
    };
}
