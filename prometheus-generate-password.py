import getpass
import bcrypt

username = input("username: ")
password = getpass.getpass("password: ")
hashed_password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt())
print(username +":"+ hashed_password.decode())
