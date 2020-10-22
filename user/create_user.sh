#adduser(Tao user)
#New password(Tao pass)
#Retype new UNIX password:
# usermod -aG sudo test_user
#get all group user 
    #cat /etc/group | grep sudo(grep lọc )
    #getent group
#Linux List All Group Names
    #cut -d: -f1 /etc/group
    #getent group | cut -d: -f1 
#Count of All the Linux Groups
    #cat /etc/group | grep -c ""
    #getent group | grep -c ""
