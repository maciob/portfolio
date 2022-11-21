db = db.getSiblingDB("admin");
db.createUser(
 {
   user: "root",
   pwd: "pass",
   roles: [
    { role:'readWrite', db:'books' }
   ]
 }
);
