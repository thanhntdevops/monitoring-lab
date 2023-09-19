import getpass
import bcrypt
import sys

if len(sys.argv[1:]) == 0:
    username = input("username: ")
    password = getpass.getpass("password: ")
elif len(sys.argv[1:]) == 2:
    username = sys.argv[1]
    password = sys.argv[2]
else:
    print("python hashpw.py username password \"or\" python hashpw.py")
    sys.exit(1)
hashed_password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
print(username +": "+ hashed_password.decode())
