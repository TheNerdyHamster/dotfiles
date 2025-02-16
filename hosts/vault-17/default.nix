_:
let
    hostname = "vault-17";
in {
    networking.hostName = hostname;
    networking.computerName = hostname;
    #system.defaults.smb.NetBIOSName = hostname;
}
